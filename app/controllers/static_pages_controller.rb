class StaticPagesController < ApplicationController
  def home
		if signed_in?
			@exercise = current_user.exercises.build 
			@feed_items = current_user.feed.paginate(page: params[:page])  	
		end
  end

  def help
  	@title="Help"
  end
end
