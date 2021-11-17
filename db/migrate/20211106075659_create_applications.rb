class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.references :customer, null: false
      t.references :request, null: false
      t.references :contract
      t.text :comment
      t.datetime :first_preferred_date
      t.datetime :last_preferred_date


      t.timestamps
    end
  end
end
