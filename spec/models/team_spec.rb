require 'spec_helper'

describe Team do
  describe "Validates" do
    it { should validate_presence_of :code }
    it { should validate_presence_of :name }
    it { should validate_presence_of :shift }
    it { should validate_presence_of :level }
  end

  describe "Associations" do
    it { should have_many :attendances }
    it { should have_many(:students).through(:attendances) }
    it { should have_many :team_activities }
    it { should have_many(:activities).through(:team_activities) }
  end
end
