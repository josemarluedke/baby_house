require 'spec_helper'

describe ParentStudent do
  describe "Associations" do
    it { should belong_to :parent }
    it { should belong_to :student }
  end
end
