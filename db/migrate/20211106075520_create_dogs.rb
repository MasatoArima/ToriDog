class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.references :customer, null: false
      t.string :name, null: false
      t.string :breed, null: false
      t.boolean :sex, null: false
      t.integer :size, null: false
      t.boolean :is_inoculate, null: false
      t.string :inoculation_date
      t.text :introduction
      t.string :profile_image
      t.string :birthday, null: false
      t.string :medical_history

      t.timestamps
    end
  end
end
