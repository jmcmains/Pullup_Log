class ExercisesController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy
	def create
		@exercise = current_user.exercises.build(params[:exercise])
		if @exercise.save
			flash[:success] = "Exercise created!"
			redirect_to root_path
		else
			flash.now[:error] = 'Invalid post'
			@feed_items = []
			render 'static_pages/home'
		end
	end
	
	def destroy
		@exercise.destroy
		redirect_to root_path
	end
	
	private
	
		def correct_user
			@exercise = current_user.exercises.find_by_id(params[:id])
			redirect_to root_path if @exercise.nil?
		end
end
