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

    context "when code exists" do
      let(:code) { create :code }

      example "Create User" do
        do_request

        expect(response_status).to eq(201)
      end
    end

    context "when code not exists" do
      let(:code) { build :code }

      example "Create User without existing code" do
        do_request

        expect(response_status).to eq(422)
      end
    end

    context "when code already taken" do
      let(:code) { create :code }
      before do
        another_user = create :user, code: code
      end

      example "Create User without existing code" do
        do_request

        expect(response_status).to eq(422)
      end
    end
  end
end
