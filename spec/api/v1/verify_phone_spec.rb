resource "Verify phone" do
  include_context "with API Headers"

  get "/v1/verify_phone" do
    parameter :value, "Phone Number", required: true

    let(:value) { phone.value }

    context "when phone exists" do
      let(:phone) { create :phone }
      let(:expected_data) do
        {
          "phone" => {
            "value" => phone.value,
            "user_id" => nil
          }
        }
      end

      example "Verify phone number" do
        do_request

        expect(response_status).to eq(200)
        expect(json_response_body).to eq(expected_data)
      end
    end

    context "when phone not exists" do
      let(:phone) { build :phone }

      example "Verify phone number which not exists in db" do
        do_request

        expect(response_status).to eq(404)
      end
    end
  end
end
