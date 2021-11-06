class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.references :customer, null: false
      t.references :request, null: false
      t.text :comment
  
  
      t.timestamps
    end
  end
end
