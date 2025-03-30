class CreateJoinTableEventsClassRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :class_rooms_events, id: false do |t|
      t.references :event, null: false, foreign_key: true, type: :uuid
      t.references :class_room, null: false, foreign_key: true, type: :uuid

      # Índices para melhorar consultas
      t.index [:event_id, :class_room_id], unique: true
      t.index [:class_room_id, :event_id]
    end
  end
end
