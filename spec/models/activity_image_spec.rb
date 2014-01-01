require 'spec_helper'

describe ActivityImage do
  describe "Validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :activity_id }
  end

  describe "Associations" do
    it { should belong_to :activity }
    it { should have_many(:buy_photos).dependent(:destroy) }
  end
end
