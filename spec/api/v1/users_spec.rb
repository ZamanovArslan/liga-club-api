resource "Users" do
  include_context "with Authorization header"

  let!(:user) { create :user }

  get "/v1/users" do
    it_behaves_like "API endpoint with authorization"

    let(:expected_data) {
      [{
          "id" => current_user.id,
          "full_name" => current_user.full_name,
          "group_number" => current_user.group_number,
          "phone_number" => current_user.phone_number,
          "university_id" => current_user.university.id
        },
        {
          "id" => user.id,
          "full_name" => user.full_name,
          "group_number" => user.group_number,
          "phone_number" => user.phone_number,
          "university_id" => user.university.id
      }]
    }

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
          "university_id" => user.university.id
        }
      }
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Specific user" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end
  end
end
