class PagesController < ApplicationController
  def dashboard
    @projects = current_user.own_projects + current_user.projects
    @topics = @project.topics
  end
end
