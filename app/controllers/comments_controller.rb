class CommentsController < ApplicationController
  before_action :check_permission
  before_action :authenticate_user!
  before_action :load_sidebar

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = Comment.new(permitted_params)
    @comment.user = current_user
    @comment.topic = @topic

    if @comment.valid? && @comment.save
      @topic.touch
      flash[:notice] = 'Comment successfully added'
      redirect_to project_topic_path(@topic.project, @topic)
    else
      @project = @topic.project
      @comments = @topic.comments
      render 'topics/show'
    end
  end

  protected

  def permitted_params
    params.require(:comment).permit([:body])
  end

  private

  def check_permission
    # Check if user is owner of project or if it belong to members
    project = Project.find(params[:project_id])
    owner   = project.user
    members = project.users

    unless owner == current_user || members.include?(current_user)
      flash[:alert] = 'You do not have permission to access this Project'
      redirect_to projects_path
    end
  end

  def load_sidebar
    @projects = current_user.own_projects + current_user.projects
    @projects = @projects.first(6).sort_by {|p| p[:created_at]}.uniq{|p| p.id}
  end
end
