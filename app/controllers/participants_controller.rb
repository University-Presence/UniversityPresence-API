# frozen_string_literal: true
# 
class ParticipantsController < ApplicationController
  include ActiveModel::Model
  attr_reader :participant

  def confirm_presence
    student = find_student
    event = event_id
    participant = find_participant(student, event)
    location = confirm_presence_params["location"]
    
    update_participant_presence(participant, location)
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
      :name, :ra, :location
    )
  end

  def find_student
    student = Student.find_by(name: confirm_presence_params["name"], ra: confirm_presence_params["ra"])
    
    unless student
      render json: { error: 'Nome ou RA inválidos' }, status: :not_found
      return nil
    end

    student
  end

  def event_id
    params["event_id"]
  end

  def find_participant(student, event_id)
    participant = Participant.find_by(student_id: student.id, event_id: )
    
    unless participant
      render json: { error: 'Participante não encontrado' }, status: :not_found
      return nil
    end

    participant
  end

  def update_participant_presence(participant, location)
    participant.update(present: true, location: location)

    render jsonapi: participant, include: include_options, class: { Participant: SerializableParticipant, Event: SerializableEvent }, status: :ok
  end
end