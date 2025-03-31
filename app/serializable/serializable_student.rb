class SerializableStudent < JSONAPI::Serializable::Resource
  type 'students'

  attributes :name, :ra

  belongs_to :class_room
end
