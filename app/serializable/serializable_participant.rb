# frozen_string_literal: true

class SerializableParticipant < JSONAPI::Serializable::Resource
  type :participant

  attributes :id, :present, :location
  
  has_one :event
end
