# Domains table
class CreateDomains < ActiveRecord::Migration[5.0]
  def change
    create_table :domains, id: :bigint do |t|
      t.string :name
      t.integer :quota

      t.timestamps
    end
  end
end
