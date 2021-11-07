class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :customer, null: false
      t.references :dog, null: false
      t.text :comment

      t.timestamps
    end
  end
end
