class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.float :rate
      t.text :comment
      t.references :contract, null: false

      t.timestamps
    end
  end
end
