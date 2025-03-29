# frozen_string_literal: true

class SerializableUser < JSONAPI::Serializable::Resource
  type :user

  attributes :id, :name, :email
end
