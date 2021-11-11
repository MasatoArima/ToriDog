class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :contract, null: false
      t.references :customer, null: false
      t.string :sender, null: false

      t.timestamps
    end
  end
end
