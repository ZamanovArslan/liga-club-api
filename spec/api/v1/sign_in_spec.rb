resource "Tokens" do
  include_context "with API Headers"

  post "/v1/sign_in" do
    with_options scope: :user do
      parameter :email, "email", required: true
      parameter :password, "password", required: true
    end

    let!(:user) { create :user }
    let(:email) { user.email }
    let(:password) { user.password }
    let(:jwt_token) { build(:jwt_token, subject: user) }
    let(:expected_data) { { "token" => jwt_token.token } }

    example_request "Create Token" do
      expect(response_status).to eq(201)
      expect(json_response_body).to eq(expected_data)
    end

    context "with invalid password" do
      let(:password) { "invalid" }
      let(:expected_error) { "Invalid credentials" }

      example "Create Token with invalid password", document: false do
        do_request

        expect(response_status).to eq(422)
        expect(json_response_body["errors"].first["error"]).to eq(expected_error)
      end
    end
  end
end
