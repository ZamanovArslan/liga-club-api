shared_context "with default resource" do
  include_context "with API Headers"

  get "/v1/#{resource.model_name.plural}" do
    example_request "List of #{resource.model_name.plural}" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq([expected_data])
    end
  end

  get "/v1/#{resource.model_name.plural}/:id" do
    let(:id) { resource.id }

    example_request "Specific #{resource.model_name.singular}" do
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end
  end
end
