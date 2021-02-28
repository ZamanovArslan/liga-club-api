resource "Badges" do
  include_context "with Authorization API headers"

  let(:badge) { create :badge }
  before do
    create :participation, :confirmed, user: current_user, badge: badge
  end

  let(:expected_data) do
    {
      "id" => badge.id,
      "name" => badge.name,
      "description" => badge.description,
      "ends_at" => badge.ends_at.strftime("%d.%m.%Y %R"),
      "rarity" => {
        "id" => badge.rarity.id,
        "name" => badge.rarity.name,
        "scores_count" => badge.rarity.scores_count,
        "image" => be_a_empty_image_attachment,
        "color" => "#ffffff"
      },
      "university" => nil,
      "image" => be_a_empty_image_attachment,
      "confirmation_method" => badge.confirmation_method,
      "is_participation" => true,
      "scope" => "republic",
      "city" => nil,
      "participation_description" => badge.participation_terms,
      "bonus_description" => nil
    }
  end

  get "/v1/my/badges" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of current user badges" do
      expect(response_status).to eq(200)
      expect(json_response_body["badges"]).to match_array([expected_data])
    end
  end
end
