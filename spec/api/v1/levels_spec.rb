resource "Levels" do
  include_context "with API Headers"

  let!(:level) { create :level }

  let(:expected_data) do
    {
      "id" => level.id,
      "name" => level.name,
      "scores_count" => level.scores_count,
      "description" => level.description
    }
  end

  get "/v1/levels" do
    example_request "List of levels" do
      expect(response_status).to eq(200)
      expect(json_response_body["levels"]).to eq([expected_data])
    end
  end

  get "/v1/levels/:id" do
    let(:id) { level.id }

    example_request "Specific level" do
      expect(response_status).to eq(200)
      expect(json_response_body["level"]).to eq(expected_data)
    end
  end
end
