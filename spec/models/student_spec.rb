require 'spec_helper'

describe Student do
  describe "validations" do
    it{ should validate_presence_of :name }
  end
end
