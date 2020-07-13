resource "Verify code" do
  include_context "with API Headers"

  get "/v1/verify_code" do
    parameter :value, "Code", required: true

    let(:value) { code.value }

    context "when code exists" do
      let(:code) { create :code }
      let(:expected_data) do
        {
          "code" => {
            "value" => code.value,
            "user_id" => nil
          }
        }
      end

      example "Verify code" do
        do_request

        expect(response_status).to eq(200)
        expect(json_response_body).to eq(expected_data)
      end
    end

    context "when code not exists" do
      let(:code) { build :code }

      example "Verify code which not exists" do
        do_request

        expect(response_status).to eq(404)
      end
    end
  end
end
