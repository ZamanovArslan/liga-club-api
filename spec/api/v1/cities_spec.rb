resource "Cities" do
  include_context "with API Headers"

  let!(:city) { create :city }

  let(:expected_data) do
    {
      "id" => city.id,
      "name" => city.name
    }
  end

  get "/v1/cities" do
    example_request "List of cities" do
      expect(response_status).to eq(200)
      expect(json_response_body["cities"]).to match_array([expected_data])
    end
  end
end
