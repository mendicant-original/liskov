class DiscussionsController < ApplicationController
  def index
    render :text => Discussion.reviews
  end
end
