require 'spec_helper'

describe Student do
  describe "Validations" do
    it{ should validate_presence_of :name }
  end

  describe "Associations" do
    it { should have_many(:parents).through(:parentages) }
    it { should have_many :parentages }
    it { should have_many(:teams).through(:attendances) }
    it { should have_many :attendances }
  end
end
