class CreateDefinitions < ActiveRecord::Migration[5.2]
  def change
    create_table :definitions do |t|
      t.references :word, foreign_key: true
      t.text :definition

      t.timestamps
    end
  end
end
