class StudentsController < ApplicationController
  before_filter :find_course, :find_student

  def show
  end
end
