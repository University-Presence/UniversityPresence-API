class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants, id: :uuid do |t|
      t.references :event, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }, type: :uuid
      t.references :student, null: false, foreign_key: { on_update: :cascade }, type: :uuid
      t.boolean :present
      t.jsonb :location, default: {}
      t.timestamps
    end
  end
end
