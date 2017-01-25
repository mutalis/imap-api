# Users table
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :bigint do |t|
      t.string :username
      t.string :password
      t.string :auth_token

      t.timestamps
    end
  end
end
