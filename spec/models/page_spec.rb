require 'spec_helper'

describe Page do
  describe "Validations" do
    it { should validate_uniqueness_of :title }
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end

  describe "Slug verification" do
    it 'Should convert the page title to a friendly_id' do
      number = rand(1000)
      page = Page.make!(:title => "My page #{number}", :body => 'content')
      page.slug.should == "my-page-#{number}"
    end
  end

  describe "#auto_html" do
    text = "A _simple_ body of *page* [This link](http://example.net/)"
    let(:page) { Page.make!(:body => text) }

    it "should have the right body" do
      page.body.should == "A _simple_ body of *page* [This link](http://example.net/)"
    end

    it "should have the right body_html" do
      page.body_html.should == "<p>A <em>simple</em> body of <em>page</em> <a href=\"http://example.net/\">This link</a></p>\n"
    end
  end
  describe "Associations" do
    it { should belong_to :category }
  end
end
