require 'spec_helper'

describe Banner do
  describe "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :link_text }
    it { should validate_presence_of :link_url }
    it { should validate_presence_of :image }
  end
end
