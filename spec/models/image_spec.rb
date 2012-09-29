require 'spec_helper'

describe Image do
  describe "Validations" do
    it { should validate_presence_of :image }
  end
end
