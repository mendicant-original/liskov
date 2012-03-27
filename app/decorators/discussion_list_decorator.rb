class DiscussionListDecorator < ApplicationDecorator
  decorates :discussions, :class => Discussion

  def category_filters
    [conversations_link, reviews_link, evaluations_link].join(" | ").html_safe
  end

  def state_filters
    output = if h.params[:state] == "closed"
      link_params = h.params.merge(:state => "open")

      "State: " +
      h.link_to("Open", h.course_discussions_path(link_params)) +
      " | Closed"
    else
      link_params = h.params.merge(:state => "closed")

      "State: Open | " +
      h.link_to("Closed", h.course_discussions_path(link_params))
    end

    output.html_safe
  end

  def matched_discussions
    discussions.all.map do |discussion|
      course     = discussion.course
      discussion = DiscussionDecorator.new(discussion)
      h.image_tag(discussion.author.gravatar_url(30), :class => "discussions") +
      h.content_tag(:p, discussion.start_date, :class => ["discussions","date"]) +
      h.link_to(
        h.content_tag(:h3, discussion.subject, :class => "discussions"),
        h.course_discussion_path(course, discussion), 
          :class => ["discussions","show"]) +
      h.content_tag(:hr)
    end.join.html_safe
  end
  
  def new_discussion_link
    h.link_to("New Discussion", 
      h.new_course_discussion_path(:category => category), 
      :class => ["discussions","new"])
  end
  
  def category
    h.params[:category] || "conversations"
  end

  private

  def discussions_link(category_name)
    if category == category_name
      category_name.capitalize
    else
      link_params = h.params.merge(:category => category_name)
      h.link_to category_name.capitalize, h.course_discussions_path(link_params)
    end
  end

  def conversations_link    
    discussions_link("conversations")
  end

  def reviews_link
    discussions_link("reviews")
  end

  def evaluations_link
   discussions_link("evaluations")
  end
end
