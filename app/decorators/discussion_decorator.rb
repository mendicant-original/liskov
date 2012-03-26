class DiscussionDecorator < ApplicationDecorator
  decorates :discussion
  allows :subject
  
  def author
    PersonDecorator.from_github_name(discussion.author)
  end
end