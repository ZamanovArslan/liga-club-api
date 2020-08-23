resource "Level" do
  include_context "with Authorization API headers"

  let!(:level) { create :level, scores_count: 10 }
  let!(:too_many_scores_count_level) { create :level, scores_count: 10 }
  let!(:suitable_level) { create :level, scores_count: 50 }
  let(:badge) { create :badge, rarity: rarity }
  let(:rarity) { create :rarity, scores_count: 50 }
  let!(:participation) { create :participation, :confirmed, user: current_user, badge: badge }
  before do
    current_user.update(score: 50)
  end

  let(:expected_data) do
    {
      "level" => {
        "id" => suitable_level.id,
        "name" => suitable_level.name,
        "scores_count" => suitable_level.scores_count,
        "description" => suitable_level.description,
        "image" => be_a_empty_image_attachment
      }
    }
  end

  get "/v1/my/level" do
    it_behaves_like "API endpoint with authorization"

    example_request "Current user level" do
      expect(response_status).to eq(200)
      expect(json_response_body).to include(expected_data)
    end
  end
end
