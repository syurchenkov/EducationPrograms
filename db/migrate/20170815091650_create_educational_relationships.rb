class CreateEducationalRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :educational_relationships do |t|
      t.references :educational, polymorphic: true, index: { name: 'index_on_educational_type_and_id' }
      t.references :education_program, index: { name: 'index_on_education_program_id' }
      t.timestamps
    end
    add_index :educational_relationships, [:educational_id, :educational_type, :education_program_id], name: 'index_unique', unique: true
  end
end
