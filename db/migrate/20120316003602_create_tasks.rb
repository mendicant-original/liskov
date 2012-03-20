class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :course
      t.string     :description

      t.timestamps
    end
  end
end
