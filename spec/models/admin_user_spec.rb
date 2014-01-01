require 'spec_helper'

describe AdminUser do
  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
