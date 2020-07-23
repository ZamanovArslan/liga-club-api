resource "Badges" do
  include_context "with Authorization header"

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
      "image" => be_a_image_attachment
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
  end
end
