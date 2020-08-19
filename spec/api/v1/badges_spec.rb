resource "Badges" do
  include_context "with Authorization API headers"

  let!(:badge) { create :badge, :with_image }

  let(:expected_data) do
    {
      "id" => badge.id,
      "name" => badge.name,
      "description" => badge.description,
      "ends_at" => badge.ends_at,
      "rarity" => {
        "id" => badge.rarity.id,
        "name" => badge.rarity.name,
        "scores_count" => badge.rarity.scores_count,
        "image" => be_a_empty_image_attachment
      },
      "university" => nil,
      "image" => be_a_image_attachment,
      "confirmation_method" => badge.confirmation_method,
      "is_participation" => false
    }
  end

  get "/v1/badges" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of only actual badges" do
      expect(response_status).to eq(200)
      expect(json_response_body["badges"]).to match_array([expected_data])
    end
  end

  get "/v1/badges/:id" do
    let(:id) { badge.id }

    it_behaves_like "API endpoint with authorization"

    example_request "Specific badge" do
      expect(response_status).to eq(200)
      expect(json_response_body["badge"]).to include(expected_data)
    end

    context "when already a participation" do
      before do
        create :participation, user: current_user, badge: badge
      end

      example_request "Returns that current user a participation" do
        expect(json_response_body["badge"]["is_participation"]).to be_truthy
      end
    end
  end
end
