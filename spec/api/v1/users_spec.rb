resource "Users with ranks" do
  include_context "with Authorization API headers"

  let!(:user) { create :user, :with_avatar, score: 50, full_name: "Ivan Petrovich" }

  get "/v1/users" do
    it_behaves_like "API endpoint with authorization"

    let(:expected_data) do
      [{
        "id" => current_user.id,
        "full_name" => current_user.full_name,
        "group_number" => current_user.group_number,
        "phone_number" => current_user.phone_number,
        "avatar" => be_a_empty_image_attachment,
        "level" => nil,
        "university" => {
          "id" => current_user.university.id,
          "name" => current_user.university.name,
          "abbreviation" => nil,
          "city" => nil
        },
        "score" => 0,
        "rank" => 2
      },
       {
         "id" => user.id,
         "full_name" => user.full_name,
         "group_number" => user.group_number,
         "phone_number" => user.phone_number,
         "avatar" => be_a_image_attachment,
         "level" => nil,
         "university" => {
           "id" => user.university.id,
           "name" => user.university.name,
           "abbreviation" => nil,
           "city" => nil
         },
         "score" => 50,
         "rank" => 1
       }]
    end

    example_request "List of users" do
      expect(response_status).to eq(200)
      expect(json_response_body["users"]).to match_array(expected_data)
    end

    context "with page params" do
      parameter :page, "Page"
      parameter :per_page, "Per page records count"

      let(:page) { 2 }
      let(:per_page) { 1 }
      let(:users) { create_list :user, 5 }

      let(:expected_data) do
        {
          "users" => [{
            "id" => current_user.id,
            "full_name" => current_user.full_name,
            "group_number" => current_user.group_number,
            "phone_number" => current_user.phone_number,
            "avatar" => be_a_empty_image_attachment,
            "level" => nil,
            "university" => {
              "id" => current_user.university.id,
              "name" => current_user.university.name,
              "abbreviation" => nil,
              "city" => nil
            },
            "score" => 0,
            "rank" => 2
          }]
        }
      end

      example_request "List of users with page parameters" do
        expect(response_status).to eq(200)
        expect(json_response_body).to include(expected_data)
      end
    end

    context "with full name and university params" do
      parameter :full_name, "Full name"
      parameter :university_id, "University id"

      let(:full_name) { "petrovich" }
      let(:university_id) { user.university.id }
      let(:expected_data) do
        {
          "users" => [{
            "id" => user.id,
            "full_name" => user.full_name,
            "group_number" => user.group_number,
            "phone_number" => user.phone_number,
            "avatar" => be_a_image_attachment,
            "level" => nil,
            "university" => {
              "id" => user.university.id,
              "name" => user.university.name,
              "abbreviation" => nil,
              "city" => nil
            },
            "rank" => 1,
            "score" => 50
          }]
        }
      end

      example_request "List of filtered users by university and full name" do
        expect(response_status).to eq(200)
        expect(json_response_body).to include(expected_data)
      end
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
          "level" => nil,
          "university" => {
            "id" => user.university.id,
            "name" => user.university.name,
            "abbreviation" => nil,
            "city" => nil
          },
          "rank" => 1,
          "score" => 50
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
