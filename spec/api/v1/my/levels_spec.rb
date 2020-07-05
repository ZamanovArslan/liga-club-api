resource "Levels" do
  include_context "with Authorization header"

  let!(:level) { create :level, scores_count: 10 }
  let!(:too_many_scores_count_level) { create :level, scores_count: 10 }
  let!(:suitable_level) { create :level, scores_count: 50 }
  let(:badge) { create :badge, rarity: rarity }
  let(:rarity) { create :rarity, scores_count: 50 }
  let!(:participation) { create :participation, :confirmed, user: current_user, badge: badge }

  let(:expected_data) do
    {
      "id" => suitable_level.id,
      "name" => suitable_level.name,
      "scores_count" => suitable_level.scores_count,
      "description" => suitable_level.description
    }
  end

  get "/v1/my/level" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of current user levels" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end
  end
end