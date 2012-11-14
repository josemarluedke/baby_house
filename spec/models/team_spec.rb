require 'spec_helper'

describe Team do
  describe "Validates" do
    it { should validate_presence_of :code }
    it { should validate_presence_of :name }
    it { should validate_presence_of :shift }
  end
end
