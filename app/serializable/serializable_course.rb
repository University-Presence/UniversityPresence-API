# frozen_string_literal: true

class SerializableCourse < JSONAPI::Serializable::Resource
  type :course

  attributes :id, :name, :periods

  has_many :students
  has_many :events
  has_many :class_rooms
end
