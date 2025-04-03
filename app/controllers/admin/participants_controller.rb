# frozen_string_literal: true

module Admin
  class ParticipantsController < ApplicationController
    include ActiveModel::Model

    before_action :authenticate_user_with_jwt, only: %i[ index show destroy ]
    attr_reader :participant

    def index
      participants = Participant.where(event_id: event_id)
      participants = participants.ransack(params[:q])
      @participants = participants.result.page(params[:page]).per(params[:per_page] || 10)

      render jsonapi: @participants, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent, Student: SerializableStudent }, status: :ok
    end

    def show
      @participant = Participant.find_by(id: find_params, event_id: event_id)

      if @participant
        render jsonapi: @participants, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent, Student: SerializableStudent }, status: :ok
      else
        render json: { error: 'Participante não encontrado' }, status: :not_found
      end
    end

    def destroy
      @participant = Participant.find_by(id: find_params, event_id: event_id)

      unless @event
        return render json: { error: 'Evento não encontrado' }, status: :not_found
      end
      
      if @participant.valid?
        @participant.delete
        render jsonapi: @participant, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent, Student: SerializableStudent }, status: :ok
      else
        render json: @participant.errors, status: :not_found
      end
    end

    private

    def participant_params
      params.require(:data).require(:attributes).permit(
       :present, :location
      )
    end

    def event_id
      params["event_id"]
    end
  end
end