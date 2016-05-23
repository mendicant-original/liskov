class AddAuthorFieldToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :author, :string
  end
end
