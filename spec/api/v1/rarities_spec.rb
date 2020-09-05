resource "Rarities" do
  include_context "with Authorization API headers"

  let!(:rarity) { create :rarity, :with_image, color: "#ececec" }

  let(:expected_data) do
    {
      "id" => rarity.id,
      "scores_count" => rarity.scores_count,
      "name" => rarity.name,
      "image" => be_a_image_attachment,
      "color" => "#ececec"
    }
  end

  get "/v1/rarities" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of rarities" do
      expect(response_status).to eq(200)
      expect(json_response_body["rarities"]).to match_array([expected_data])
    end
  end

  get "/v1/rarities/:id" do
    let(:id) { rarity.id }

    it_behaves_like "API endpoint with authorization"

    example_request "Specific rarity" do
      expect(response_status).to eq(200)
      expect(json_response_body["rarity"]).to include(expected_data)
    end
  end
end
