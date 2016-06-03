class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true, foreign_key: true
      t.boolean :finished, default: false
      t.string :description, null: false, default: ''

      t.timestamps null: false
    end
  end
end
