class CreateOutgoings < ActiveRecord::Migration
  def change
    create_table :outgoings do |t|
      t.string :note
      t.date :date
      t.decimal :sum
      t.references :category, index: true, foreign_key: true
      t.references :pocket, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
