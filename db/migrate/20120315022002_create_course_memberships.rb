class CreateCourseMemberships < ActiveRecord::Migration
  def change
    create_table :course_memberships do |t|
      t.belongs_to :course
      t.string     :person_github_nickname
      t.string     :role

      t.timestamps
    end
  end
end
