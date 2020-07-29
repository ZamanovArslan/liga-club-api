resource "Sign up" do
  header "Content-Type", "application/json"
  header "Accept", "application/json"

  post "/v1/sign_up" do
    with_options scope: :user do
      parameter :group_number, "Group number", required: true
      parameter :password, "Password", required: true
      parameter :phone_number, "Phone number", required: true
      parameter :full_name, "Full name", required: true
      parameter :code_value, "Code", required: true
      parameter :university_id, "University id", required: true
      parameter :avatar, "Avatar", "Type" => "Multipart/Form-data"
    end

    let(:university) { create :university }

    let(:user) { build :user }
    let(:group_number) { user.group_number }
    let(:password) { user.password }
    let(:phone_number) { user.phone_number }
    let(:full_name) { user.full_name }
    let(:password) { user.password }
    let(:group_number) { user.group_number }
    let(:phone_number) { user.phone_number }
    let(:code_value) { code.value }
    let(:university_id) { university.id }
    let(:avatar) { Rack::Test::UploadedFile.new("spec/support/fixtures/image.png", "image/png") }
    let(:new_user) { User.last }

    context "when code exists" do
      let(:code) { create :code }

      example "Create User" do
        do_request

        expect(new_user.code).to eq(code)
        expect(new_user.avatar.url).to eq("/uploads/user/avatar/#{new_user.id}/image.png")
        expect(response_status).to eq(201)
      end
    end

    context "without required fields" do
      let(:code) { create :code }
      let(:full_name) { nil }
      let(:expected_data) do
        {
          "errors" => [
            {
              "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
              "status" => 422,
              "error" => "Неверные данные",
              "validations" => "Имя и фамилия не могут быть пустыми"
            }
          ]
        }
      end

      example "not creates eser", document: false do
        do_request

        expect(response_status).to eq(422)
      end
    end

    context "when code not exists" do
      let(:code) { build :code }

      example "not creates user", document: false do
        do_request

        expect(response_status).to eq(422)
      end
    end

    context "when code already taken" do
      let(:code) { create :code }
      let(:expected_data) do
        {
          "errors" => [
            {
              "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
              "status" => 422,
              "error" => "Неверные данные",
              "validations" => "Код уже занят"
            }
          ]
        }
      end

      before do
        create :user, code: code
      end

      example "not creates user", document: false do
        do_request

        expect(response_status).to eq(422)
      end
    end
  end
end
