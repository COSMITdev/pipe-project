require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:project_id) }
    it { should validate_presence_of(:description) }
  end

  describe "Relations" do
    it { should belong_to(:project) }
  end
end
