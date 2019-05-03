require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #new" do
        it "should render new sign up page" do
            get :new, {}
            expect(response).to render_template('new')
            expect(response).to have_http_status(200)
        end
    end

    describe "POST #create" do
        it "should render new if there is missing password error" do
            post :create, params: { user: { username: 'testguy1'}}
            expect(response).to render_template('new')
            expect(flash[:errors]).to be_present
        end

        it "should render new if there is missing username error" do
            post :create, params: { user: { password: 'testguy1'}}
            expect(response).to render_template('new')
            expect(flash[:errors]).to be_present
        end

        it "should render new if password too short error" do
            post :create, params: { user: { username: 'testguy1', password: "pass"}}
            expect(response).to render_template('new')
            expect(flash[:errors]).to be_present
        end

        it "should redirect to users show page if successful" do
            post :create, params: { user: { username: 'testguy1', password: "password123"}}
            user = User.find_by(username: 'testguy1')
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(user_url(user))
        end
        
    end

    describe "GET #show" do
        let!(:user){ create(:user)}

        it "should render show" do 
            get :show, params: { id: user.id }
            expect(response).to render_template('show')
            expect(response).to have_http_status(200)
        end
    end
end
