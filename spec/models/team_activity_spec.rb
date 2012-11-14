require 'spec_helper'

describe TeamActivity do
  describe "Associations" do
    it { should belong_to :activity }
    it { should belong_to :team }
  end
end
