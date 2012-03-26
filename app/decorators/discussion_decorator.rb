class DiscussionDecorator < ApplicationDecorator
  decorates :discussion
  allows :subject
  
  def author
    PersonDecorator.from_github_name(discussion.author)
  end
  
  def start_date
    discussion.created_at.strftime("%Y-%m-%d")
  end
end