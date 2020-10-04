resource "Universities" do
  include_context "with API Headers"

  let!(:university) { create :university, abbreviation: "KFU", city: "Kazan" }

  let(:expected_data) do
    {
      "id" => university.id,
      "name" => university.name,
      "abbreviation" => "KFU",
      "city" => "Kazan"
    }
  end

  get "/v1/universities" do
    example_request "List of universities" do
      expect(response_status).to eq(200)
      expect(json_response_body["universities"]).to eq([expected_data])
    end
  end

  get "/v1/universities/:id" do
    let(:id) { university.id }

    example_request "Specific university" do
      expect(response_status).to eq(200)
      expect(json_response_body["university"]).to eq(expected_data)
    end
  end
end
