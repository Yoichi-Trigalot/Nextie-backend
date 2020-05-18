class HomeController < ApplicationController
    def index
        if current_user.admin
            @unicorns = Unicorn.all
            render json: @unicorns
        else
            @unicorns = Unicorn.where(user_id == current_user.id )
            render json: @unicorns
        end
    end
end
