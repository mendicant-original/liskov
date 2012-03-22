class AddArchivedFieldToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :archived, :boolean, :default => false
  end
end
