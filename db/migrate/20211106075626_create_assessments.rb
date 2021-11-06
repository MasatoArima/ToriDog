class CreateAssessments < ActiveRecord::Migration[5.2]
  def change
    create_table :assessments do |t|
      t.integer :like_id, null: false
      t.integer :get_like_id, null: false

      t.timestamps
    end
  end
end
