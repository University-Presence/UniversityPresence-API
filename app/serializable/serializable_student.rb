class SerializableStudent < JSONAPI::Serializable::Resource
  type :students

  attributes :name, :ra, :class_room_id

  belongs_to :class_room
  has_many :participants
end
