ActiveAdmin.register Topic do
  permit_params :user_id, :project_id, :title, :body
end
