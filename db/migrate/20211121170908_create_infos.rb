class CreateInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :infos do |t|
      t.references :customer, null: false
      t.string :best_breed
      t.string :best_cut
      t.integer :price_large
      t.integer :price_medium
      t.integer :price_small

      t.timestamps
    end
  end
end
