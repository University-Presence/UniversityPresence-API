# frozen_string_literal: true
# 
class ParticipantsController < ApplicationController
  include ActiveModel::Model
  attr_reader :participant

  def confirm_presence
    student = find_student
    event = Event.find_by(id: params["event_id"])
    participant = find_participant(student, event)
    
    update_participant_presence(participant, event)
  end

  def show_event
    event = Event.find_by(id: event_id)

    if event
      render jsonapi: event, include: include_options, class: { Event: SerializableEvent, Course: SerializableCourse }, status: :ok
    else
      render json: { error: 'Evento não encontrado' }, status: :not_found
    end
  end

  private

  def confirm_presence_params
    params.require(:data).require(:attributes).permit(
      :ra, :longitude, :latitude
    )
  end

  def find_student
    student = Student.find_by( ra: confirm_presence_params["ra"] )
    
    unless student
      render json: { error: 'Nome ou RA inválidos' }, status: :not_found
      return nil
    end

    student
  end

  def find_participant(student, event)
    participant = Participant.find_by(student_id: student.id, event: event)
    
    unless participant
      render json: { error: 'Participante não encontrado' }, status: :not_found
      return nil
    end

    participant
  end

  def update_participant_presence(participant, event)
    event_latitude = format('%.10f', event.latitude).to_f
    event_longitude = format('%.10f', event.longitude).to_f

    location_service = Location::GetLocationParticipant.new(
      confirm_presence_params[:latitude],
      confirm_presence_params[:longitude],
      event_latitude,
      event_longitude
    )

    distance = location_service.distance(confirm_presence_params[:latitude], confirm_presence_params[:longitude], event.latitude, event.longitude)

    if distance > Location::GetLocationParticipant::ALLOWED_RADIUS
      render json: { error: 'Participante está fora da área do evento' }, status: :unprocessable_entity
      return
    end

    location = location_service.perform

    participant.update(present: true, location: location["display_name"])
    render jsonapi: participant, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent }, status: :ok
  end
end