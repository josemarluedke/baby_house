require 'spec_helper'

describe AlbumOrder do
  describe "Validations" do
    it { should validate_presence_of(:parent) }
  end

  describe "Relations" do
    it { should belong_to(:parent) }
  end

  describe "#purchase" do
    let!(:album_order) { AlbumOrder.make! }
    let!(:hex) { SecureRandom.stub(:hex).and_return(hex = '800426fe5b2cf34ace8a28851cf504c3'); hex }

    context "ignoring #create_zip" do
      before { album_order.stub(:create_zip).and_return(true) }

      it "Changes filename" do
        DateTime.stub(:now).and_return(DateTime.new(2014, 1, 6, 9, 50, 0))
        expected = "#{album_order.id}_06-01-2014-07-50-00_#{hex}.zip"
        expect{
          album_order.purchase
        }.to change(album_order, :filename).from('').to(expected)
      end

      it "Changes #finished_at to DateTime.now" do
        expected = DateTime.new(2014, 1, 6, 9, 50, 0)
        DateTime.stub(:now).and_return(expected)
        expect{
          album_order.purchase
        }.to change(album_order, :finished_at).from(nil).to(expected)
      end
    end

    it "Creates a .zip in public/zip"
  end
end
