# require "spec_helper"

# describe Api::V1::SessionsController , :type => :api do

#   let!(:user) { FactoryGirl.create(:user) }

#   it "making a request without cookie token " do
#     get :index
#     response.status.should eql(401)
#     error = {:error=>'You need to sign in or sign up before continuing.'}
#     response.body.should  eql(error.to_json)
#   end

# end