resource "Levels" do
  include_context "with API Headers"

  let!(:level) { create :level }

  let(:expected_data) do
    {
      "id" => level.id,
      "name" => level.name,
      "scores_count" => level.scores_count,
      "description" => level.description,
      "image" => be_a_empty_image_attachment,
      "bonus_description" => nil
    }
  end

  get "/v1/levels" do
    example_request "List of levels" do
      expect(response_status).to eq(200)
      expect(json_response_body["levels"]).to match_array([expected_data])
    end
  end

  get "/v1/levels/:id" do
    let(:id) { level.id }

    example_request "Specific level" do
      expect(response_status).to eq(200)
      expect(json_response_body["level"]).to include(expected_data)
    end
  end
end
