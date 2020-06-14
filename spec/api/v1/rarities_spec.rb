resource "Rarities" do
  include_context "with Authorization header"

  let!(:rarity) { create :rarity }

  let(:expected_data) do
    {
      "id" => rarity.id,
      "scores_count" => rarity.scores_count,
      "name" => rarity.name
    }
  end

  get "/v1/rarities" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of rarities" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq([expected_data])
    end
  end

  get "/v1/rarities/:id" do
    let(:id) { rarity.id }

    it_behaves_like "API endpoint with authorization"

    example_request "Specific rarity" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end
  end
end
