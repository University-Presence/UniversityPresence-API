class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants, id: :uuid do |t|
      t.references :event, null: false, foreign_key: true, type: :uuid
      t.boolean :present
      t.string :location
      t.timestamps
    end
  end
end
