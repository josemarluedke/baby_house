require 'spec_helper'

describe Banner do
  describe "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :link_url }
    it { should validate_presence_of :image }

    context ".link_url" do
      it { should allow_value('http://twitter.com').for(:link_url) }
      it { should allow_value('http://twitter.com/babyhouse').for(:link_url) }
      it { should allow_value('http://twitter.com/#!/babyhouse').for(:link_url) }
      it { should allow_value('https://twitter.com').for(:link_url) }
      it { should allow_value('https://twitter.com/babyhouse').for(:link_url) }
      it { should allow_value('https://twitter.com/#!/babyhouse').for(:link_url) }
      it { should_not allow_value(nil).for(:link_url) }
      it { should_not allow_value('').for(:link_url) }
      it { should_not allow_value('ftp://hello@server.com').for(:link_url) }
    end
  end

  describe "#latest" do
    it "should return nil if empty" do
      Banner.latest.should == nil
    end

    it "should return the latest visible video" do
      Banner.make! visible: true, title: "0001"
      Banner.make! visible: true, title: "0002"
      Banner.make! visible: false, title: "0003"
      Banner.latest.title.should == "0002"
    end
  end

  describe ".visible" do
    subject { Banner.visible }

    let(:visible_banner) { Banner.make!(visible: true) }
    let(:hidden_banner) { Banner.make!(visible: false) }

    context "hidden banners" do
      before { hidden_banner }

      it "returns nothing" do
        expect(subject).to be_empty
      end
    end

    context "visible banners" do
      before { visible_banner }

      it "returns something" do
        expect(subject).to_not be_empty
      end

      it "includes visible banner" do
        expect(subject).to include(visible_banner)
      end

      it "not includes hidden banner" do
        expect(subject).to_not include(hidden_banner)
      end
    end
  end
end
