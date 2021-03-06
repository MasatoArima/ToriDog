class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :customer, null: false
      t.references :dog, null: false
      t.text :comment
      t.string :prefecture_code, null: false
      t.boolean :is_complete, null: false, default: false
      t.datetime :first_preferred_date
      t.datetime :last_preferred_date

      t.timestamps
    end
  end
end
