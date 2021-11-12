class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :customer, null: false
      t.references :room, null: false
      t.text :message, null: false
      
      t.timestamps
    end
  end
end
