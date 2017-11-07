require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it "renders the new links page" do
      get :new

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      before(:each) do
        post :create, params: { user: { username: 'maddog', password: 'asdf' } }
      end

      it "renders new page again" do
        expect(response).to render_template('new')
      end

      it "flashes errors" do
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      before(:each) do
        post :create, params: { user: { username: 'maddog', password: 'good_password' } }
      end

      it "redirects to goals index page" do
        expect(response).to redirect_to(goals_url)
      end

      it "logs in user" do
        expect(session[:session_token]).to_not be_nil
        expect(session[:session_token]).to eq(User.last.session_token)

      end
    end
  end
end



# new renders new


# create w/ valid params
# redirect to goals index
#
# create w/ invalid
# render new again
# shows flash errors
