resource "Levels" do
  include_context "with Authorization header"

  let!(:level) { create :level, scores_count: 10 }
  let!(:second_level) { create :level, scores_count: 60 }
  let(:badge) { create :badge, rarity: rarity }
  let(:rarity) { create :rarity, scores_count: 50 }
  let!(:participation) { create :participation, :confirmed, user: current_user, badge: badge }

  let(:expected_data) do
    {
      "id" => level.id,
      "name" => level.name,
      "scores_count" => level.scores_count,
      "description" => level.description
    }
  end

  get "/v1/my/levels" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of current user levels" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq([expected_data])
    end
  end
end
