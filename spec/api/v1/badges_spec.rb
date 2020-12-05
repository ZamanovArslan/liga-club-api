resource "Badges" do
  include_context "with Authorization API headers"

  let!(:badge) { create :badge, name: "Do something", university: university, ends_at: nil }
  let(:university) { create :university, :with_city, name: "KPFU" }

  let(:expected_data) do
    {
      "id" => badge.id,
      "name" => badge.name,
      "description" => badge.description,
      "ends_at" => nil,
      "rarity" => {
        "id" => badge.rarity.id,
        "name" => badge.rarity.name,
        "scores_count" => badge.rarity.scores_count,
        "image" => be_a_empty_image_attachment,
        "color" => "#ffffff"
      },
      "university" => {
        "id" => university.id,
        "name" => university.name,
        "abbreviation" => university.abbreviation,
        "city" => {
          "id" => university.city.id,
          "name" => university.city.name
        }
      },
      "image" => be_a_empty_image_attachment,
      "confirmation_method" => badge.confirmation_method.to_a,
      "is_participation" => false,
      "scope" => "republic",
      "city" => nil,
      "participation_description" => badge.participation_terms,
      "bonus_description" => nil
    }
  end

  get "/v1/badges" do
    it_behaves_like "API endpoint with authorization"

    example_request "List of all badges" do
      expect(response_status).to eq(200)
      expect(json_response_body["badges"]).to match_array([expected_data])
    end
  end

  context "with filter" do
    parameter :city_id, "City id", required: false
    parameter :university_id, "University id", required: false
    parameter :actual, "Actuality", required: false
    parameter :rarity_id, "Rarity id", required: false
    parameter :name, "Name", required: false

    let(:city_id) { badge.university.city.id }
    let(:university_id) { badge.university.id }
    let(:actual) { true }
    let(:rarity_id) { badge.rarity.id }
    let(:name) { "Do something" }

    let!(:badge_without_specific_university) { create :badge, :with_image }
    let!(:badge_from_other_university) { create :badge, :with_university }

    get "/v1/badges" do
      it_behaves_like "API endpoint with authorization"

      example_request "Filtered badges" do
        expect(response_status).to eq(200)

        expect(json_response_body["badges"]).to match_array([expected_data])
      end
    end
  end

  get "/v1/badges/:id" do
    let(:id) { badge.id }

    it_behaves_like "API endpoint with authorization"

    example_request "Specific badge" do
      expect(response_status).to eq(200)
      expect(json_response_body["badge"]).to include(expected_data)
    end

    context "when already a participation" do
      before do
        current_user.university = badge.university

        create :participation, user: current_user, badge: badge
      end

      example_request "Returns that current user a participation", document: false do
        expect(json_response_body["badge"]["is_participation"]).to be_truthy
      end
    end
  end
end
