require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:proejct_id) }
  end

  describe "Relations" do
    it { should belong_to :user }
    it { should belong_to :project }
  end
end
