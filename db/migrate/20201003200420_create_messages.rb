class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :time
      t.integer :user_id
      t.integer :dialogue_id

      t.timestamps
    end
  end
end
