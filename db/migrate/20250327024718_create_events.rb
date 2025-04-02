class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string :name
      t.string :description
      t.datetime :event_start
      t.datetime :event_end
      t.references :course, null: false, foreign_key: { on_update: :cascade }, type: :uuid
      t.string :location

      t.timestamps
    end
  end
end
