class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :category
      
      t.text :subject
      t.text :body

      t.belongs_to :course

      t.timestamps
    end
  end
end
