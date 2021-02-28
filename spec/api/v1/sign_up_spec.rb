resource "Sign up" do
  header "Content-Type", "application/json"
  header "Accept", "application/json"

  post "/v1/sign_up" do
    with_options scope: :user do
      parameter :group_number, "Group number", required: true
      parameter :password, "Password", required: true
      parameter :phone_number, "Phone number", required: true
      parameter :first_name, "First name", required: true
      parameter :last_name, "Last name", required: true
      parameter :university_id, "University id", required: true
      parameter :avatar, "Avatar", "Type" => "Multipart/Form-data"
    end

    let(:university) { create :university }
    let(:user) { build :user }
    let(:group_number) { user.group_number }
    let(:password) { user.password }
    let(:first_name) { user.first_name }
    let(:last_name) { user.last_name }
    let(:password) { user.password }
    let(:group_number) { user.group_number }
    let(:phone_number) { phone.value }
    let(:university_id) { university.id }
    let(:avatar) { Rack::Test::UploadedFile.new("spec/support/fixtures/image.png", "image/png") }
    let(:new_user) { User.last }
    let(:phone) { create :phone }

    context "when phone exists" do
      example "Create User" do
        do_request

        expect(response_status).to eq(201)
        expect(new_user.phone).to eq(phone)
        expect(new_user.avatar.url).to eq("/uploads/user/avatar/#{new_user.id}/image.png")
      end
    end

    context "without required fields" do
      let(:first_name) { nil }
      let(:expected_data) do
        {
          "errors" => [
            {
              "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
              "status" => 422,
              "error" => "Неверные данные",
              "validations" => "Имя не может быть пустым"
            }
          ]
        }
      end

      example "not creates user", document: false do
        do_request

        expect(json_response_body).to eq(expected_data)
        expect(response_status).to eq(422)
      end
    end

    context "when phone not exists" do
      let(:phone) { build :phone }
      let(:expected_data) do
        {
          "errors" => [
            {
              "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
              "status" => 422,
              "error" => "Неверные данные",
              "validations" => "Телефонный номер не найден"
            }
          ]
        }
      end

      example "not creates user", document: false do
        do_request

        expect(response_status).to eq(422)
        expect(json_response_body).to eq(expected_data)
      end
    end

    context "when phone already taken" do
      let(:expected_data) do
        {
          "errors" => [
            {
              "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
              "status" => 422,
              "error" => "Неверные данные",
              "validations" => "Телефонный номер уже занят"
            }
          ]
        }
      end

      before do
        create :user, phone: phone
      end

      example "not creates user", document: false do
        do_request

        expect(response_status).to eq(422)
        expect(json_response_body).to eq(expected_data)
      end
    end

    context "when image not correct" do
      let(:avatar) { Rack::Test::UploadedFile.new("spec/support/fixtures/large_image.jpg", "image/jpg") }

      let(:expected_data) do
        {
          "errors" => [
            {
              "id" => "4eac02e2-6856-449b-bc28-fbf1b32a20f2",
              "status" => 422,
              "error" => "Неверные данные",
              "validations" => "Аватар должен быть меньше, чем 3,0 МБ"
            }
          ]
        }
      end

      example "not creates user", document: false do
        do_request

        expect(response_status).to eq(422)
        expect(json_response_body).to eq(expected_data)
      end
    end
  end
end
