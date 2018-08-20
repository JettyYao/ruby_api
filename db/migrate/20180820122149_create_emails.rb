class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.string :username
      t.string :account
      t.text :content
      t.boolean :isread

      t.timestamps
    end
  end
end
