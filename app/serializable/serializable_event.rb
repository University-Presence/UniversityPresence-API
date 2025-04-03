# frozen_string_literal: true

class SerializableEvent < JSONAPI::Serializable::Resource
  type :event

  attributes :id, :name, :description, :event_start, :event_end, :course_id, :location, :latitude, :longitude
  
  belongs_to :course
  has_many :class_rooms
  has_many :participants
end