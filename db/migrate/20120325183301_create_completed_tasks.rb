class CreateCompletedTasks < ActiveRecord::Migration
  def change
    create_table :completed_tasks do |t|
      t.belongs_to :course_membership
      t.belongs_to :task
      t.string     :description
    end
  end
end
