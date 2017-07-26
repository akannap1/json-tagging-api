class CreateEntityIdentifiers < ActiveRecord::Migration
  def change
    create_table :entity_identifiers do |t|
      t.string :entity_id
      t.references :entity_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
