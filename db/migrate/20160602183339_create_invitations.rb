class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :project, index: true, foreign_key: true
      t.string :email

      t.timestamps null: false
    end
  end
end
