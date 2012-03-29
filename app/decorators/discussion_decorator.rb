class DiscussionDecorator < ApplicationDecorator
  decorates :discussion
  allows :subject, :body
  
  def author
    PersonDecorator.from_github_name(discussion.author)
  end
  
  def start_date
    discussion.created_at.strftime("%Y-%m-%d")
  end
  
  def header
    h.content_tag(:p, start_date, :class => ["discussions","date"]) +
    h.image_tag(author.gravatar_url(30), :class => "discussions")   +
    h.content_tag(:h2, discussion.subject)
  end
  
  def body
    discussion.body.to_s.html_safe
  end

  def state
    discussion.archived ? "closed" : "open"
  end
  
  # TODO: Support unarchive
  def footer
    [ edit_link, archive_link, discussion_list_link ].join(" | ").html_safe
  end

  private

  def edit_link
    path = h.edit_course_discussion_path(discussion.course.id, discussion.id)

    h.link_to("Edit", path)
  end

  def archive_link
    h.link_to_if(!discussion.archived, "Archive", 
      h.course_discussion_path(discussion.course.id, discussion.id), 
      :method => :delete, :confirm => "Are you sure?") { "Unarchive" }
  end

  def discussion_list_link
    h.link_to("Back to #{discussion.category}", 
      h.course_discussions_path(:category => discussion.category, 
                                :state    => state))
  end
end
