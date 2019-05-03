require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
    let!(:user) { create(:user) }
    
    describe "GET #new" do
        it "should render :new template" do
            get :new, params: {user_id: user.id}
            expect(response).to render_template(:new)
            expect(response).to have_http_status(200)
        end
    end
   
    describe "POST #create" do
        context "should have the following criteria satisfied" do
            it "is not missing title" do
                post :create, params: { user_id: user.id, goal: {
                    body: 'b',
                    completed: false,
                    privacy: 'Public' } }
                expect(response).to render_template('new')
                expect(flash[:errors]).to be_present
            end

            it "is not missing body" do
                post :create, params: {user_id: user.id, goal: {
                    title: 'a',
                    completed: false,
                    privacy: 'Public' } }
                expect(response).to render_template('new')
                expect(flash[:errors]).to be_present
            end

            it "is not missing completed" do
                post :create, params: {user_id: user.id, goal: {
                    title: 'a',
                    body: 'b',
                    privacy: 'Public' } }
                expect(response).to render_template('new')
                expect(flash[:errors]).to be_present
            end

            it "is not missing privacy" do
                post :create, params: {user_id: user.id, goal: {
                    title: 'a',
                    body: 'b',
                    completed: false} }
                expect(response).to render_template('new')
                expect(flash[:errors]).to be_present
            end
        end

        context "should redirect to 'show' page when successful" do
            it "redirects to show page" do
                post :create, params: {user_id: user.id, goal: {
                    title: 'a',
                    body: 'b',
                    privacy: 'Public',
                    completed: false}}
                
                goal = Goal.find_by_title('a')
                expect(response).to have_http_status(302)
                expect(response).to redirect_to(goal_url(goal))
            end
        end

    end

    
end
