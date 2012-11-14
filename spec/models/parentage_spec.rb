require 'spec_helper'

describe Parentage do
  describe "Associations" do
    it { should belong_to :parent }
    it { should belong_to :student }
  end
end
