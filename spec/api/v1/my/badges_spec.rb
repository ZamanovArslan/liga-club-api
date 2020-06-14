resource "Badges" do
  include_context "with Authorization header"

  let(:badge) { create :badge }
  before do
    create :participation, :confirmed, user: current_user, badge: badge
  end

  let(:expected_data) do
    {
      "id" => badge.id,
      "name" => badge.name,
      "description" => badge.description,
      "ends_at" => badge.ends_at,
      "rarity" => {
        "id" => badge.rarity.id,
        "name" => badge.rarity.name,
        "scores_count" => badge.rarity.scores_count
      },
      "university" => nil
    }
  end

  get "/v1/my/badges" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of current user badges" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq([expected_data])
    end
  end
end
