class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :username
      t.string :account
      t.text :content
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
