resource "Badges" do
  include_context "with Authorization API headers"

  let!(:badge_without_specific_university) { create :badge, :with_image }
  let!(:badge_from_other_university) { create :badge, :with_university }

  let(:expected_data) do
    {
      "id" => badge_without_specific_university.id,
      "name" => badge_without_specific_university.name,
      "description" => badge_without_specific_university.description,
      "ends_at" => badge_without_specific_university.ends_at.to_datetime.strftime("%m.%d.%Y %R"),
      "rarity" => {
        "id" => badge_without_specific_university.rarity.id,
        "name" => badge_without_specific_university.rarity.name,
        "scores_count" => badge_without_specific_university.rarity.scores_count,
        "image" => be_a_empty_image_attachment,
        "color" => "#ffffff"
      },
      "university" => nil,
      "image" => be_a_image_attachment,
      "confirmation_method" => badge_without_specific_university.confirmation_method,
      "is_participation" => false
    }
  end

  get "/v1/badges" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of only actual badges" do
      expect(response_status).to eq(200)
      expect(json_response_body["badges"]).to match_array([expected_data])
    end
  end

  get "/v1/badges/:id" do
    let(:id) { badge_without_specific_university.id }

    it_behaves_like "API endpoint with authorization"

    example_request "Specific badge" do
      expect(response_status).to eq(200)
      expect(json_response_body["badge"]).to include(expected_data)
    end

    context "when already a participation" do
      before do
        create :participation, user: current_user, badge: badge_without_specific_university
      end

      example_request "Returns that current user a participation", document: false do
        expect(json_response_body["badge"]["is_participation"]).to be_truthy
      end
    end
  end
end
