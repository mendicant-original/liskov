class DiscussionListDecorator < ApplicationDecorator
  decorates :discussion

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
    all.map do |discussion| 
      h.content_tag(:h3, discussion.subject)
    end.join.html_safe
  end

  private

  def discussions_link(category_name)
    if h.params[:category] == category_name
      category_name.capitalize
    else
      link_params = h.params.merge(:category => category_name)
      h.link_to category_name.capitalize, h.course_discussions_path(link_params)
    end
  end

  def conversations_link    
    return "Conversations" if h.params[:category].blank?

    discussions_link("conversations")
  end

  def reviews_link
    discussions_link("reviews")
  end

  def evaluations_link
   discussions_link("evaluations")
  end
end
