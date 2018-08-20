class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.string :created_by

      t.timestamps
    end
  end
end
