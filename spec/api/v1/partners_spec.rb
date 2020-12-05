resource "Partners" do
  include_context "with API Headers"

  let!(:partner) { create :partner, city: city }
  let!(:partner_1) { create :partner, city: city_1 }
  let(:city) { create :city }
  let(:city_1) { create :city }
  let(:expected_data) do
    {
      "id" => partner.id,
      "name" => partner.name,
      "description" => partner.description,
      "discount" => partner.discount,
      "instagram_link" => partner.instagram_link,
      "image" => be_a_empty_image_attachment,
      "city" => {
        "id" => city.id,
        "name" => city.name
      }
    }
  end

  context "when filtered by city" do
    parameter :city_id, "City id", required: false
    let(:city_id) { city.id }

    get "/v1/partners" do
      example_request "List of partners filtered by city" do
        expect(response_status).to eq(200)
        expect(json_response_body["partners"]).to match_array([expected_data])
      end
    end
  end
end
