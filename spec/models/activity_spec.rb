require 'spec_helper'

describe Activity do
  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "Associations" do
    it { should have_many :team_activities }
    it { should have_many :teams }
  end
end
