# frozen_string_literal: true

module Admin
  class ParticipantsController < ApplicationController
    include ActiveModel::Model

    before_action :authenticate_user_with_jwt, only: %i[ index show destroy ]
    attr_reader :participant

    def index
      participants = Participant.all
      participants = participants.ransack(params[:q])
      @participants = participants.result.page(params[:page]).per(params[:per_page] || 10)

      render jsonapi: @participants, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent }, status: :ok
    end

    def show
      @participant = Participant.find_by(id: find_params)

      if @participant
        render jsonapi: @participant, class: { Participant: SerializableParticipant }, status: :ok
      else
        render json: { error: 'Participante não encontrado' }, status: :not_found
      end
    end

    def confirm_presence
      student = find_student
      participant = find_participant(student)
      location = confirm_presence_params[:location]
      
      update_participant_presence(participant, location)

      render jsonapi: @participant, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent }, status: :ok
    end

    def destroy
      @participant = Participant.find_by(id: find_params)

      unless @event
        return render json: { error: 'Evento não encontrado' }, status: :not_found
      end
      
      if @participant.valid?
        @participant.delete
        render jsonapi: @participant, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent }, status: :ok
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

    def confirm_presence_params
      params.require(:data).require(:attributes).permit(
       :name, :ra, :location
      )
    end

    def find_student
      student = Student.find_by(name: confirm_presence_params[:name], ra: confirm_presence_params[:ra])
      
      unless student
        render json: { error: 'Nome ou RA inválidos' }, status: :not_found
        return nil
      end

      student
    end

    def find_participant(student)
      participant = Participant.find_by(student_id: student.id)
      
      unless participant
        render json: { error: 'Participante não encontrado' }, status: :not_found
        return nil
      end

      participant
    end

    def update_participant_presence(participant, location)
      participant.update!(present: true, location: location)

      render jsonapi: participant, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent }, status: :ok
    end
  end
end