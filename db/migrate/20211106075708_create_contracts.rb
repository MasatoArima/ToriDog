class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :application, null: false
      t.float :rate
      t.integer :is_status, null: false
      t.boolean :dog_owner_is_consent, null: false, default: false
      t.boolean :trimmer_is_consent, null: false, default: false
      t.datetime :preferred_date
      t.integer :client_id, null: false
      t.integer :trimmer_id, null: false

      t.timestamps
    end
  end
end
