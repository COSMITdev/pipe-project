require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Relations" do
    it { should have_many(:topics).dependent(:destroy) }
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
