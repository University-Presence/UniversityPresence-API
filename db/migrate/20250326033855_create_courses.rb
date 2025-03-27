class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :name
      t.integer :periods

      t.timestamps
    end
  end
end
