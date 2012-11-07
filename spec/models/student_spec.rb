require 'spec_helper'

describe Student do
  describe "Validations" do
    it{ should validate_presence_of :name }
  end

  describe "Associations" do
    it { should have_many :parents }
    it { should have_many :parent_students }
  end
end
