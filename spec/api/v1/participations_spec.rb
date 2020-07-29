resource "Participation" do
  include_context "with Authorization header"

  header "Content-Type", "application/json"
  header "Accept", "application/json"

  post "/v1/participations" do
    with_options scope: :participation do
      parameter :badge_id, "Badge id", required: true
      parameter :attachment_confirmation, "Attachment confirmation", "Type" => "Multipart/Form-data"
      parameter :text_confirmation, "Text confirmation"
    end

    let(:badge) { create :badge }
    let(:badge_id) { badge.id }
    let(:text_confirmation) { "I was there, I swear" }
    let(:expected_data) do
      {
        "id" => Participation.last.id,
        "confirmed" => Participation.last.confirmed,
        "text_confirmation" => "I was there, I swear",
        "attachment_confirmation" => be_a_image_attachment,
        "user" =>
          {
            "id" => current_user.id,
            "full_name" => current_user.full_name,
            "group_number" => current_user.group_number,
            "phone_number" => current_user.phone_number,
            "avatar" => be_a_empty_image_attachment,
            "scores_count" => 0,
            "university" => {
              "id" => current_user.university.id,
              "name" => current_user.university.name
            }
          },
        "badge_id" => badge.id
      }
    end
    let(:attachment_confirmation) do
      Rack::Test::UploadedFile.new("spec/support/fixtures/image.png", "image/png")
    end

    it_behaves_like "API endpoint with authorization"

    example_request "Create participation for current user" do
      expect(response_status).to eq(201)
      expect(json_response_body["participation"]).to include(expected_data)
    end
  end
end
