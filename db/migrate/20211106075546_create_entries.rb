class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :customer, null: false
      t.references :room, null: false

      t.timestamps
    end
  end
end
