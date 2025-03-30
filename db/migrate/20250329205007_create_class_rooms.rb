class CreateClassRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :class_rooms, id: :uuid do |t|
      t.string :name, null: false
      t.references :course, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
