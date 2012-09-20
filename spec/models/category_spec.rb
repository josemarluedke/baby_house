require 'spec_helper'

describe Category do
  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "Associations" do
    it { should have_many :pages }
  end
end
