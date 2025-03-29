# frozen_string_literal: true

class SerializableCourse < JSONAPI::Serializable::Resource
  has_many :events
  
  type :course

  attributes :id, :name, :periods
end
