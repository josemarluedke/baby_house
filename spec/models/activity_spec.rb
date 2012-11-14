require 'spec_helper'

describe Activity do
  describe "Validations" do
    it { should validate_presence_of :name }
  end
end
