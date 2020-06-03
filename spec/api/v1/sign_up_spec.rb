resource "Registration" do
  include_context "with API Headers"

  post "/v1/sign_up" do
    with_options scope: :user do
      parameter :full_name, "Full name"
      parameter :email, "Email", required: true
      parameter :group_number, "Group number", required: true
      parameter :password, "Password", required: true
      parameter :phone_number, "Phone number", required: true
    end

    let(:user) { build :user }
    let(:full_name) { user.full_name }
    let(:email) { user.email }
    let(:password) { user.password }
    let(:group_number) { user.group_number }
    let(:phone_number) { user.phone_number }

    let(:expected_data) do
      {
        "id" => User.last.id,
        "email" => user.email,
        "full_name" => user.full_name,
        "group_number" => user.group_number,
        "phone_number" => user.phone_number
      }
    end

    example_request "Create User" do
      expect(response_status).to eq(201)
      expect(json_response_body).to eq(expected_data)
    end
  end
end
