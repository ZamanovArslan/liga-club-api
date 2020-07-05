resource "Sign up" do
  include_context "with API Headers"

  post "/v1/sign_up" do
    with_options scope: :user do
      parameter :group_number, "Group number", required: true
      parameter :password, "Password", required: true
      parameter :phone_number, "Phone number", required: true
      parameter :full_name, "Full name", required: true
      parameter :code_value, "Code", required: true
      parameter :university_id, "University id", required: true
    end

    let(:university) { create :university }

    let(:user) { build :user }
    let(:full_name) { user.full_name }
    let(:password) { user.password }
    let(:group_number) { user.group_number }
    let(:phone_number) { user.phone_number }
    let(:code_value) { code.value }
    let(:university_id) { university.id }
    let(:jwt_token) { build(:jwt_token, subject: User.last) }
    let(:expected_data) { { "token" => jwt_token.token } }

    context "when code exists" do
      let(:code) { create :code }

      example "Create User" do
        do_request

        expect(response_status).to eq(201)
        expect(json_response_body).to eq(expected_data)
      end
    end

    context "when code not exists" do
      let(:code) { build :code }

      example "Create User without existing code" do
        do_request

        expect(response_status).to eq(422)
      end
    end
  end
end
