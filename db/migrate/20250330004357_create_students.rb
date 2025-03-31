class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students, id: :uuid do |t|
      t.string :name, null: false
      t.string :ra, null: false, index: { unique: true }
      t.references :class_room, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }, type: :uuid

      t.timestamps
    end
  end
end
