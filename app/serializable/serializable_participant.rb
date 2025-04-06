# frozen_string_literal: true

class SerializableParticipant < JSONAPI::Serializable::Resource
  type :participant

  attributes :id, :present, :location, :event_id, :student_id, :student_ra, :student_name

  belongs_to :event
  belongs_to :student

  attribute :student_name do
    @object.student.name
  end

  attribute :student_ra do
    @object.student.ra
  end
end
