class CreateStudyPlans < ActiveRecord::Migration
  def up
    create_table(:study_plans) do |t|
      t.references  :course_membership
      t.text        :content
    end
  end

  def down
    drop_table(:study_plans)
  end
end
