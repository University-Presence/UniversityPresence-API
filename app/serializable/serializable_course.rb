# frozen_string_literal: true

class SerializableCourse < JSONAPI::Serializable::Resource
  type :course

  attributes :id, :name, :periods
end
