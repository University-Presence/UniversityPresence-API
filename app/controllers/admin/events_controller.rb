# frozen_string_literal: true

module Admin
  class EventsController < ApplicationController
    include ActiveModel::Model
    attr_reader :event

    def index
      event = Event.all
      event = event.ransack(params[:q])
      @event = event.result.page(params[:page]).per(params[:per_page] || 10)

      render jsonapi: @event, class: { Event: SerializableEvent }, status: :ok
    end

    def show
      @event = Event.find_by(id: find_params)

      if @event
        render jsonapi: @event, class: { Event: SerializableEvent }, status: :ok
      else
        render json: { error: 'Evento não encontrado' }, status: :not_found
      end
    end

    def create
      @event = Event.new(event_params)
      return if vaidate_dates

      if @event.valid?
        @event.save!
        render jsonapi: @event, class: { Event: SerializableEvent }, status: :created
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

      return if vaidate_dates

      if @event.valid?
        @event.save!
        render jsonapi: @event, class: { Event: SerializableEvent }, status: :ok
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
        render jsonapi: @event, class: { Event: SerializableEvent }, status: :ok
      else
        render json: @event.errors, status: :not_found
      end
    end

    private

    def find_params
      params.require(:id)
    end

    def event_params
      params.require(:data).require(:attributes).permit(
        :name, :description, :event_start, :event_end, :course_id, :location
      )
    end

    def merge_instance_errors
      return if event.nil?

      errors.attribute_names.each do |key|
        event.errors.add(key, errors[key].join(', ').to_s) unless event.errors.include?(key)
      end
    end

    def vaidate_dates
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
  end
end