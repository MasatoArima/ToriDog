class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :application, null: false
      t.float :rate
      t.integer :is_status, null: false

      t.timestamps
    end
  end
end
