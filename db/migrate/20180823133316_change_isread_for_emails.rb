class ChangeIsreadForEmails < ActiveRecord::Migration[5.2]
  def change
    change_column :emails, :isread, :boolean, :default=>false
  end
end
