class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :period
      t.decimal :sum_income
      t.decimal :sum_outgoing
      t.decimal :balance
      t.references :pocket, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
