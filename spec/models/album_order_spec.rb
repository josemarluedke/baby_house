require 'spec_helper'

describe AlbumOrder do
  describe "Validations" do
    it { should validate_presence_of(:parent) }
  end

  describe "Relations" do
    it { should belong_to(:parent) }
    it { should have_many(:buy_photos) }
    it { should have_many(:activity_images).through(:buy_photos) }
  end

  describe "#purchase" do
    let!(:album_order) { AlbumOrder.make! }
    let!(:buy_photo) { BuyPhoto.make!(album_order: album_order) }
    let!(:hex_code) { SecureRandom.stub(:hex).and_return(hex = '800426fe5b2cf34ace8a28851cf504c3'); hex }
    let(:date) { DateTime.new(2014, 1, 6, 9, 50, 0) }

    after do
      file = AlbumOrder::ZIP_LOCATION.join(album_order.filename)
      if album_order.filename.present? && File.exists?(file)
        FileUtils.rm_rf file
      end
    end

    it "Changes #filename" do
      DateTime.stub(:now).and_return(date)
      expected = "#{album_order.id}_06-01-2014_07-50-00_#{hex_code}.zip"
      expect{
        album_order.purchase
      }.to change(album_order, :filename).from('').to(expected)
    end

    it "Changes #finished_at to DateTime.now" do
      DateTime.stub(:now).and_return(date)
      album_order.stub(:create_zip).and_return(true)
      expect{
        album_order.purchase
      }.to change(album_order, :finished_at).from(nil).to(date)
    end

    it "Creates a .zip in public/zip" do
      expect{
        album_order.purchase
      }.to change{Dir[AlbumOrder::ZIP_LOCATION.join("*.zip")].count}.by(1)
    end
  end
end
