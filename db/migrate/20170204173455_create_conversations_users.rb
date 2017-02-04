class CreateConversationsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :conversations do |t|
      t.index [:user_id, :conversation_id]
    end
  end
end
