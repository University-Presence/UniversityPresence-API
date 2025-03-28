# frozen_string_literal: true

class SerializableEvent < JSONAPI::Serializable::Resource
  type :event

  attributes :id, :name, :description, :event_start, :event_end, :course_id, :location
  
  has_one :course
end
