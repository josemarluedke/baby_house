require 'spec_helper'

describe Activity do
  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "Associations" do
    it { should have_many :team_activities }
    it { should have_many :teams }
    it { should have_many :activity_images }
  end

  describe "Permissions" do
    before do
      @parent1 = Parent.make!
      @parent2 = Parent.make! name: "Rafael Barboza", email: "rafael@babyhouse.com"
      @student1 = Student.make! parents: [@parent1]
      @student2 = Student.make! name: "Rafael Barboza Jr.", parents: [@parent2]
      @team1 = Team.make! students: [@student1]
      @team2 = Team.make! code: "0002", name: "Robotica", students: [@student1, @student2]
      @team3 = Team.make! code: "0003", name: "Futebol", students: [@student2]
      @activity1 = Activity.make! teams: [@team1]
      @activity2 = Activity.make! name: "Robotica", teams: [@team2]
      @activity3 = Activity.make! name: "Futebol", teams: [@team3]
    end

    describe "#can_see_activity" do
      it "can see their son's activities" do
        @activity1.can_see_activity(@parent1).should be_true
      end

      it "cant see other's activities" do
        @activity3.can_see_activity(@parent1).should be_false
      end
    end

    describe "parent_activities" do
      it "should contain the activities related to the parent" do
        Activity.parent_activities(@parent1).should include(@activity1, @activity2)
      end

      it "should not contain other's activities" do
        Activity.parent_activities(@parent2).should_not include(@activity1)
      end
    end
  end
end
