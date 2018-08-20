class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.string :username
      t.string :account
      t.text :content
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
