class CommentsController < ApplicationController
  before_action :check_permission

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = Comment.new(permitted_params)
    @comment.user = current_user
    @comment.topic = @topic

    if @comment.valid? && @comment.save
      flash[:notice] = 'Comentário adicionado com sucesso!'
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
    owner   = Project.find(params[:project_id]).user
    members = Project.find(params[:project_id]).users

    unless owner == current_user || members.include?(current_user)
      flash[:alert] = 'Você não tem permissão para acessar este projeto.'
      redirect_to projects_path
    end
  end
end
