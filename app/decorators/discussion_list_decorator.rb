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

  def conversations_link
    link_params = h.params.merge(:category => "conversation")

    h.link_to "Conversations", h.course_discussions_path(link_params)
  end

  def reviews_link
    link_params = h.params.merge(:category => "review")

    h.link_to "Reviews", h.course_discussions_path(link_params)
  end

  def evaluations_link
    link_params = h.params.merge(:category => "evaluation")

    h.link_to "Evaluations", h.course_discussions_path(link_params)
  end
end
