resource "Sign in" do
  include_context "with API Headers"

  post "/v1/sign_in" do
    with_options scope: :user do
      parameter :phone_number, "Phone number", required: true
      parameter :password, "Password", required: true
    end

    let!(:user) { create :user }
    let(:password) { user.password }
    let(:phone_number) { user.phone_number }
    let(:jwt_token) { build(:jwt_token, subject: user) }
    let(:expected_data) { { "value" => jwt_token.token } }

    example_request "Create Token" do
      expect(response_status).to eq(201)
      expect(json_response_body["token"]).to eq(expected_data)
    end

    context "with invalid password" do
      let(:password) { "invalid" }
      let(:expected_data) do
        {
          "errors" => [
            {
              "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
              "status" => 422,
              "error" => "Неверные данные",
              "validations" => "Неверный номер телефона или пароль"
            }
          ]
        }
      end

      example "Create Token with invalid password" do
        do_request

        expect(json_response_body).to eq(expected_data)
      end
    end
  end
end
