# Domains table
class CreateDomains < ActiveRecord::Migration[5.0]
  def change
    create_table :domains do |t|
      t.string :name
      t.integer :quota

      t.timestamps
    end
  end
end
