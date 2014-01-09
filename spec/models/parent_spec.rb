require 'spec_helper'

describe Parent do
  before do
    @parent = Parent.make!
  end

  it "should valid" do
    @parent.should be_valid
  end

  describe "password required?" do
    context "news parents" do
      before do
        @parent = Parent.new
      end

      it "requires a password" do
        @parent.should be_password_required
      end

      it "should require password & match confirmation" do
        @parent.password = nil
        @parent.password_confirmation = nil
        @parent.should_not be_valid

        @parent.password = "Josemar"
        @parent.password_confirmation = nil
        @parent.should_not be_valid

        @parent.password = "Josemar"
        @parent.password_confirmation = "Luedke"
        @parent.should_not be_valid
      end
    end

    context "existing parent" do
      before do
        @parent.save!
        @parent = Parent.find @parent.id
        end

      it "requires a password when password is present" do
        @parent.password = 'josemar'
        @parent.should be_password_required
      end

      it "requires a correct password when password_comfirmation is present" do
        @parent.password_confirmation = 'xx'
        @parent.should be_password_required
      end

      it "should not require password no password or confirmation is present" do
        @parent.reload.should_not be_password_required
      end

      it "shoult not be required password" do
        @parent.password = nil
        @parent.password_confirmation = nil
        @parent.should be_valid
      end
    end
  end

  describe "Validations" do
    subject { @parent }

    it{ should validate_presence_of :name }
    it{ should validate_presence_of :email }
    it{ should validate_presence_of :password }
  end

  describe "Associations" do
    it { should have_many :parentages }
    it { should have_many(:buy_photos).dependent(:destroy) }
    it { should have_many(:students).through(:parentages) }
    it { should have_many(:album_orders).dependent(:destroy) }
  end

  describe "#admin?" do
    it { should_not be_admin }
  end
end
