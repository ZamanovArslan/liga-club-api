resource "Users" do
  include_context "with Authorization header"

  let!(:user) { create :user, :with_avatar }

  get "/v1/users" do
    it_behaves_like "API endpoint with authorization"

    let(:expected_data) do
      [{
        "id" => current_user.id,
        "full_name" => current_user.full_name,
        "group_number" => current_user.group_number,
        "phone_number" => current_user.phone_number,
        "avatar" => be_a_empty_image_attachment,
        "scores_count" => 0,
        "level" => nil,
        "university" => {
          "id" => current_user.university.id,
          "name" => current_user.university.name
        }
      },
       {
         "id" => user.id,
         "full_name" => user.full_name,
         "group_number" => user.group_number,
         "phone_number" => user.phone_number,
         "avatar" => be_a_image_attachment,
         "scores_count" => 0,
         "level" => nil,
         "university" => {
           "id" => user.university.id,
           "name" => user.university.name
         }
       }]
    end

    example_request "List of users" do
      expect(response_status).to eq(200)
      expect(json_response_body["users"]).to match_array(expected_data)
    end
  end

  get "/v1/users/:id" do
    let(:id) { user.id }
    let(:expected_data) do
      {
        "user" => {
          "id" => user.id,
          "full_name" => user.full_name,
          "group_number" => user.group_number,
          "phone_number" => user.phone_number,
          "avatar" => be_a_image_attachment,
          "scores_count" => 0,
          "level" => nil,
          "university" => {
            "id" => user.university.id,
            "name" => user.university.name
          }
        }
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Specific user" do
      expect(response_status).to eq(200)
      expect(json_response_body).to include(expected_data)
    end
  end
end
