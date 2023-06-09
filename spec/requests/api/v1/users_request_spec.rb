require "rails_helper"

RSpec.describe "User Request" do
  describe "User Create" do
    it "creates a new user" do
      user_params = ({
                      email: "abc@123.com",
                      password: "password123"
                    })

      headers = { "CONTENT_TYPE" => "application/json" }

      post api_v1_users_path, headers: headers, params: JSON.generate( user: user_params )

      created_user = User.last

      expect(response).to be_successful

      expect(created_user.email).to eq("abc@123.com")
      expect(created_user.user_type).to eq("donor")
    end

		it "does not allow user to be created if invalid properties" do
			user_params = ({
				email: "abc",
				password: "password123"
			})

			headers = { "CONTENT_TYPE" => "application/json" }

			post api_v1_users_path, headers: headers, params: JSON.generate( user: user_params )

			expect(response).to have_http_status(404)

			response_body = JSON.parse(response.body, symbolize_names: true)

			expect(response_body.keys).to match([:message, :errors])

			expect(response_body[:message]).to be_a String
			expect(response_body[:errors]).to be_an Array

			response_body[:errors].each do |error|
				expect(error).to be_a Hash
				expect(error.keys).to match([:status, :title])

				expect(error[:status]).to be_a String
				expect(error[:status]).to eq("404")

				expect(error[:title]).to be_a String
				expect(error[:title]).to eq("Email is invalid")
			end
		end
  end
end