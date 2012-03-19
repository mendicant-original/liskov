class Course < ActiveRecord::Base
  has_many :discussions
  has_many :course_memberships


  after_create :build_wiki_repo

  def people
    @people ||= course_memberships.map {|cm| cm.person }
  end

  def build_wiki_repo
    FileUtils.mkdir("wikis/#{id}")
    FileUtils.mkdir("wikis/#{id}/repo.git")
    Grit::Repo.new("wikis/#{id}/repo.git")
  end
end
