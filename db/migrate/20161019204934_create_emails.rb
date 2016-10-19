# Emails table
class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails, id: :uuid do |t|
      t.string :username
      t.string :quota
      t.string :password

      t.timestamps
    end
  end
end
