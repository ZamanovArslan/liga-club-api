resource "News" do
  include_context "with API Headers"

  let!(:news) { create :news }

  let(:expected_data) do
    {
      "id" => news.id,
      "title" => news.title,
      "description" => news.description
    }
  end

  get "/v1/news" do
    example_request "List of news" do
      expect(response_status).to eq(200)
      expect(json_response_body["news"]).to match_array([expected_data])
    end
  end
end
