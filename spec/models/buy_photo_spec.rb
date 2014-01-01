require 'spec_helper'

describe BuyPhoto do
  describe "Validations" do
    it { should validate_uniqueness_of(:activity_image_id).scoped_to(:parent_id) }
    it { should validate_presence_of(:activity_image) }
    it { should validate_presence_of(:parent) }
  end

  describe "Relations" do
    it { should belong_to(:activity_image) }
    it { should belong_to(:parent) }
  end

  describe "::PRICE" do
    it "returns 10" do
      expect(BuyPhoto::PRICE).to eq(10)
    end
  end
end
