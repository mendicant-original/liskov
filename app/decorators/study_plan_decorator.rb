class StudyPlanDecorator < ApplicationDecorator
  decorates :study_plan

  def content
    MdPreview::Parser.parse(study_plan.content)
  end
end
