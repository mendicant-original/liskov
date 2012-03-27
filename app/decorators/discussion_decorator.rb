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
    h.image_tag(author.gravatar_url(30), :class => "discussions") +
    h.content_tag(:h2, discussion.subject)
  end
  
  def body
    discussion.body.to_s.html_safe
  end
  
  # TODO: Support unarchive
  def footer
    link_params = [h.params["course_id"], h.params["id"]]
    [ h.link_to("Edit", h.edit_course_discussion_path(*link_params)), 
      h.link_to_if(!discussion.archived, "Archive", 
                h.course_discussion_path(*link_params), 
                :method => :delete, :confirm => "Are you sure?") { "Unarchive" },
      h.link_to("Back to #{discussion.category}", h.course_discussions_path(:category => discussion.category))
     ].join(" | ").html_safe
  end
end