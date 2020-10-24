class AddDialogueIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :dialogue_id, :integer
  end
end
