# frozen_string_literal: true

module Admin
  class StudentsController < ApplicationController
    before_action :authenticate_user_with_jwt

    def index
      students = Student.all
      students = students.where(class_room_id: params[:class_room_id]) if params[:class_room_id].present?
      students = students.ransack(params[:q])
      @students = students.result.page(params[:page]).per(params[:per_page] || 10)

      render jsonapi: @students, include: include_options, class: { Student: SerializableStudent, ClassRoom: SerializableClassRoom }, status: :ok
    end

    def show
      @student = Student.find_by(id: find_params)

      if @student
        render jsonapi: @student, include: include_options, class: { Student: SerializableStudent, ClassRoom: SerializableClassRoom }, status: :ok
      else
        render json: { error: 'Estudante não encontrado' }, status: :not_found
      end
    end
  end
end
