resource "Participation" do
  include_context "with Authorization header"

  let(:badge) { create :badge }
  let(:badge_id) { badge.id }
  let(:expected_data) do
    {
      "id" => Participation.last.id,
      "confirmed" => Participation.last.confirmed,
      "user" =>
        {
          "id" => current_user.id,
          "full_name" => current_user.full_name,
          "group_number" => current_user.group_number,
          "phone_number" => current_user.phone_number,
          "university_id" => current_user.university.id
        },
      "badge_id" => badge.id
    }
  end

  post "/v1/participations" do
    parameter :badge_id, "Badge id", required: true

    it_behaves_like "API endpoint with authorization"

    example_request "Create participation for current user" do
      expect(response_status).to eq(201)
      expect(json_response_body).to eq(expected_data)
    end
  end
end
