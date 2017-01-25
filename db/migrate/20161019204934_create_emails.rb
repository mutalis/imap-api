# Emails table
class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :username, index: { unique: true }
      t.integer :quota
      t.string :password

      t.timestamps
    end
  end
end
