require 'spec_helper'

describe BuyPhoto do
  describe "Validations" do
    it { should validate_uniqueness_of(:activity_image_id).scoped_to(:parent_id) }
  end
end
