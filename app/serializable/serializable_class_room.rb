# frozen_string_literal: true

class SerializableClassRoom < JSONAPI::Serializable::Resource
  type 'class_rooms'

  attributes :name

  belongs_to :course
end
