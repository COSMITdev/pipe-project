require 'rails_helper'

RSpec.describe ProjectUser, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:project_id) }
  end

  describe "Relations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end
end
