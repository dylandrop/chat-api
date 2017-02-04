class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content

      t.timestamps null: false
    end

    add_reference :messages, :conversation, foreign_key: true, null: false
    add_reference :messages, :user, foreign_key: true, null: false
  end
end
