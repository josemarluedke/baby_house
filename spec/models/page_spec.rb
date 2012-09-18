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
end
