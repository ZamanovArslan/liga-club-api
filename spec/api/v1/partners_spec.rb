resource "Partners" do
  include_context "with API Headers"

  let!(:partner) { create :partner }

  let(:expected_data) do
    {
      "id" => partner.id,
      "name" => partner.name,
      "description" => partner.description,
      "discount" => partner.discount,
      "instagram_link" => partner.instagram_link,
      "image" => be_a_empty_image_attachment
    }
  end

  get "/v1/partners" do
    example_request "List of partners" do
      expect(response_status).to eq(200)
      expect(json_response_body["partners"]).to match_array([expected_data])
    end
  end
end
