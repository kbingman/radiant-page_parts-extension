require File.dirname(__FILE__) + '/../spec_helper'

describe PagePart do
  it "should initialize with text content" do
    part = PagePart.new(:content => 'sweet harmonious biscuits')
    part.text_content.should eql('sweet harmonious biscuits')
  end

  it "should alias text content" do
    part = PagePart.new(:content => 'sweet harmonious biscuits')
    part.content.should eql('sweet harmonious biscuits')
  end

  describe ".new" do
    it "should cast instance to subclass if type is given" do
      part = PagePart.new(:page_part_type => 'BooleanPagePart')
      part.class.should be(BooleanPagePart)
    end

    it "should use parent class if type is omitted" do
      part = PagePart.new
      part.class.should be(PagePart)
    end

    it "should use parent class if type is a mismatch" do
      part = PagePart.new(:page_part_type => 'Page')
      part.class.should be(PagePart)
    end
  end

  describe ".content" do
    # Reset default for next test
    after do
      PagePart.content = :text
    end

    it "should set storage column" do
      PagePart.content = :integer
      PagePart.content_column.should eql('integer_content')
    end

    it "should alias content attribute" do
      part = PagePart.new(:text_content => "text", :integer_content => 123)
      part.content.should eql('text')
      PagePart.content = :integer
      part.content.should eql(123)
    end
  end

  describe ".partial_name" do
    it "should be text if page part is not subclassed" do
      PagePart.partial_name.should eql('text_page_part')
    end

    it "should use class name if page part is subclassed" do
      BooleanPagePart.partial_name.should eql('boolean_page_part')
    end
  end
end