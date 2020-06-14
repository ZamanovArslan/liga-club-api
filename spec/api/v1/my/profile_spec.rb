resource "My Profile" do
  include_context "with Authorization header"

  let(:current_user) { create :user }

  get "/v1/my/profile" do
    let(:expected_data) do
      {
        "id" => User.last.id,
        "full_name" => current_user.full_name,
        "group_number" => current_user.group_number,
        "phone_number" => current_user.phone_number,
        "university_id" => current_user.university.id
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Retrieve Profile" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end
  end

  patch "/v1/my/profile" do
    with_options scope: :user do
      parameter :full_name, "Full name"
      parameter :phone_number, "Phone number"
      parameter :password, "Password"
      parameter :group_number, "Group number"
      parameter :university_id, "University id"
    end

    let(:id) { current_user.id }
    let(:full_name) { "Updated Name" }
    let(:phone_number) { "+79393619602" }
    let(:password) { "new_password" }
    let(:group_number) { "11-707" }
    let(:university_id) { new_university.id }
    let(:new_university) { create :university, name: "KNITU" }

    let(:expected_data) do
      {
        "id" => id,
        "phone_number" => phone_number,
        "full_name" => full_name,
        "group_number" => group_number,
        "university_id" => university_id
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Update Profile" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end

    context "with invalid data" do
      let(:password) { "" }

      let(:expected_data) do
        {
          "error" => "Invalid record",
          "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
          "status" => 422,
          "validations" => {
            "password" => ["is too short (minimum is 6 characters)"]
          }
        }
      end

      example "Update Profile with empty password and invalid email", document: false do
        do_request

        expect(response_status).to eq(422)
        expect(json_response_body).to eq(expected_data)
      end
    end
  end

  delete "/v1/my/profile" do
    let(:expected_data) do
      {
        "id" => current_user.id,
        "phone_number" => current_user.phone_number,
        "full_name" => current_user.full_name,
        "group_number" => current_user.group_number,
        "university_id" => current_user.university.id
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Delete Profile" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end
  end
end
