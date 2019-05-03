class GoalsController < ApplicationController

    def index
        render :index
    end

    def show
        render :show
    end

    def new
        render :new
    end

    def create
        @goal = Goal.new(goal_params)
        @goal.user_id = params[:user_id]
        if @goal.save
            redirect_to goal_url(@goal)
        else
            debugger
            flash.now[:errors] = @goal.errors.full_messages
            render :new
        end
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def goal_params
        params.require(:goal).permit(:completed, :body, :title, :privacy)
    end

end