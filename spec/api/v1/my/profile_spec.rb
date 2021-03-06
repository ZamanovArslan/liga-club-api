resource "My Profile" do
  let!(:second_user) { create :user, score: 20 }

  get "/v1/my/profile" do
    include_context "with Authorization API headers"

    let(:expected_data) do
      {
        "user" => {
          "id" => User.last.id,
          "full_name" => current_user.full_name,
          "first_name" => current_user.first_name,
          "last_name" => current_user.last_name,
          "group_number" => current_user.group_number,
          "phone_number" => current_user.phone.value,
          "level" => nil,
          "university" => {
            "id" => current_user.university.id,
            "name" => current_user.university.name,
            "abbreviation" => nil,
            "city" => nil
          },
          "avatar" => be_a_empty_image_attachment,
          "score" => 0,
          "rank" => 2
        }
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Retrieve Profile" do
      expect(response_status).to eq(200)
      expect(json_response_body).to include(expected_data)
    end
  end

  patch "/v1/my/profile" do
    include_context "with Authorization header"

    with_options scope: :user do
      parameter :first_name, "First name"
      parameter :last_name, "Last name"
      parameter :group_number, "Group number"
      parameter :university_id, "University id"
      parameter :avatar, "Avatar"
    end

    let(:id) { current_user.id }
    let(:first_name) { "NewName" }
    let(:last_name) { "NewLastName" }
    let(:password) { "new_password" }
    let(:group_number) { "11-707" }
    let(:university_id) { new_university.id }
    let(:new_university) { create :university, name: "KNITU" }
    let(:avatar) { Rack::Test::UploadedFile.new(File.join("spec/support/fixtures", "image.png")) }

    let(:expected_data) do
      {
        "id" => id,
        "first_name" => "NewName",
        "last_name" => "NewLastName",
        "group_number" => group_number,
        "level" => nil,
        "score" => 0,
        "university" => {
          "id" => current_user.reload.university.id,
          "name" => current_user.reload.university.name,
          "abbreviation" => nil,
          "city" => nil
        },
        "avatar" => be_a_image_attachment
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Update Profile" do
      expect(response_status).to eq(200)
      expect(json_response_body["user"]).to include(expected_data)
    end

    #   context "with invalid data" do
    #     let(:password) { nil }
    #
    #     let(:expected_data) do
    #       {
    #         "errors" => [
    #           {
    #             "error" => "Неверные данные",
    #             "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
    #             "status" => 422,
    #             "validations" => "Пароль недостаточной длины (не может быть меньше 6 символов)"
    #           }
    #         ]
    #       }
    #     end
    #
    #     example "Update Profile with empty password and invalid email", document: false do
    #       do_request
    #
    #       expect(response_status).to eq(422)
    #       expect(json_response_body).to eq(expected_data)
    #     end
    #   end
  end

  delete "/v1/my/profile" do
    include_context "with Authorization API headers"

    let(:expected_data) do
      {
        "id" => current_user.id,
        "full_name" => current_user.full_name,
        "group_number" => current_user.group_number,
        "avatar" => be_a_empty_image_attachment,
        "university" => {
          "id" => current_user.university.id,
          "name" => current_user.university.name,
          "abbreviation" => nil,
          "city" => nil
        }
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Delete Profile" do
      expect(response_status).to eq(200)
      expect(json_response_body["user"]).to include(expected_data)
    end
  end
end
