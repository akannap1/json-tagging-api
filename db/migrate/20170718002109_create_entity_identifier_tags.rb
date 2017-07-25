class CreateEntityIdentifierTags < ActiveRecord::Migration
  def change
    create_table :entity_identifier_tags do |t|
      t.references :entity_identifier, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
