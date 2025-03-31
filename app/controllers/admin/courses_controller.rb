# frozen_string_literal: true

module Admin
  class CoursesController < ApplicationController
    before_action :authenticate_user_with_jwt

    def index
      courses = Course.all
      courses = courses.ransack(params[:q])
      @courses = courses.result.page(params[:page]).per(params[:per_page] || 10)

      render jsonapi: @courses, class: { Course: SerializableCourse }, status: :ok
    end

    def show
      @course = Course.find_by(id: find_params)

      if @course
        render jsonapi: @course, class: { Course: SerializableCourse }, status: :ok
      else
        render json: { error: 'Curso não encontrado' }, status: :not_found
      end
    end

    private
    
    def course_params
      params.require(:course).permit(:name, :periods)
    end
  end
end
