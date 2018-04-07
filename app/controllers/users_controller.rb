class UsersController < ApplicationController
    def show
        #binding.pry
        #current_user
        # => nil
        #Loginしないと値は反映されない。
        @nickname = current_user.nickname
        #binding.pry
        #@tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC")
        @tweets = current_user.tweets.page(params[:page]).per(5).order("created_at DESC")
    end
end
