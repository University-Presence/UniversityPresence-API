# frozen_string_literal: true

module Admin
  class EventsController < ApplicationController
    before_action :authenticate_user_with_jwt

    include ActiveModel::Model
    attr_reader :event, :class_room_ids

    def index
      event = Event.all
      event = event.ransack(params[:q])
      @event = event.result.page(params[:page]).per(params[:per_page] || 10)

       render jsonapi: @event, include: include_options, class: { Event: SerializableEvent, Course: SerializableCourse }, status: :ok
    end

    def show
      @event = Event.find_by(id: find_params)

      if @event
        render jsonapi: @event, include: include_options, class: { Event: SerializableEvent, Course: SerializableCourse }, status: :ok
      else
        render json: { error: 'Evento não encontrado' }, status: :not_found
      end
    end

    def create
      @event = Event.new(event_params)
      @class_room_ids = event_params["class_room_ids"]
      return if validate_dates
      return if validate_classroom_course

      if @event.valid?

        create_class_rooms_events
        @event.save!
        render jsonapi: @event, include: include_options, class: { Event: SerializableEvent, Course: SerializableCourse }, status: :created
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    def update
      @event = Event.find_by(id: find_params)

      unless @event
        return render json: { error: 'Evento não encontrado' }, status: :not_found
      end

      @event&.assign_attributes(event_params)

      return if validate_dates
      return if validate_classroom_course

      if @event.valid?
        @event.save!
        create_class_rooms_events
        render jsonapi: @event, include: include_options, class: { Event: SerializableEvent, Course: SerializableCourse }, status: :ok
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @event = Event.find_by(id: find_params)

      unless @event
        return render json: { error: 'Evento não encontrado' }, status: :not_found
      end


      if @event.valid?
        @event.delete
        render jsonapi: @event, include: include_options, class: { Event: SerializableEvent, Course: SerializableCourse }, status: :ok
      else
        render json: @event.errors, status: :not_found
      end
    end

    private

    def event_params
      params.require(:data).require(:attributes).permit(
        :name, :description, :event_start, :event_end, :course_id, :location, class_room_ids: []
      )
    end

    def validate_dates
      return true if validate_start_date
      return true if validate_end_date
      false
    end

    def validate_start_date
      if event.event_start.present?
        event_start = event.event_start.to_time

        if event_start < Time.current
          render json: { error: "Você não pode definir datas anteriores à atual" }, status: :unprocessable_entity
        end
      end
    end

    def validate_end_date
      if event.event_end.present?
        event_end = event.event_end.to_time

        if event_end < event.event_start.to_time
          render json: { error: "A data de encerramento não pode ser anterior a data de início" }, status: :unprocessable_entity
        end
      end
    end

    def validate_classroom_course
      if class_room_ids.present?
        class_room_ids.each do |class_room_id|
          class_room = ClassRoom.find_by(id: class_room_id)
          return if class_room&.course_id == event.course_id
            render json: { error: "A turma #{class_room.name} não pertence ao curso #{event.course.name}" }, status: :unprocessable_entity
        end
      end
    end

    def create_class_rooms_events
      if class_room_ids.present?
        class_room_ids.each do |class_room_id|
          ClassRoomsEvent.create(event_id: event.id, class_room_id: class_room_id)
        end
      end
    end
  end
end
