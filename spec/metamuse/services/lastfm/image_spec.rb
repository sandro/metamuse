require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Metamuse::Services::Lastfm::Image do
  before do
    @small_location = "http://userserve-ak.last.fm/serve/34s/14349365.jpg"
    @medium_location = "http://userserve-ak.last.fm/serve/64s/14349365.jpg"
    @large_location = "http://userserve-ak.last.fm/serve/126/14349365.jpg"
    @extra_large_location = "http://userserve-ak.last.fm/serve/300x300/14349365.jpg"
  end

  subject { Metamuse::Services::Lastfm::Image.new @small_location }

  it "has a small size" do
    subject.size.should == :small
  end

  it "has small dimensions" do
    subject.dimensions.should == Metamuse::Services::Lastfm::Image::DIMENSIONS.index(:small)
  end

  describe "#size" do
    context "supported sizes" do
      it "returns small size" do
        image = Metamuse::Services::Lastfm::Image.new @small_location
        image.size.should == :small
      end

      it "returns medium size" do
        image = Metamuse::Services::Lastfm::Image.new @medium_location
        image.size.should == :medium
      end

      it "returns large size" do
        image = Metamuse::Services::Lastfm::Image.new @large_location
        image.size.should == :large
      end

      it "returns extra large size" do
        image = Metamuse::Services::Lastfm::Image.new @extra_large_location
        image.size.should == :extra_large
      end
    end

    context "unsupported size" do
      it "returns nil size" do
        image = Metamuse::Services::Lastfm::Image.new '/images/1.jpg'
        image.size.should be_nil
      end
    end
  end

  describe "#dimensions" do
    it "finds the dimensions of a small image" do
      subject.dimensions.should == "34x34"
    end
  end

  describe "width and height" do
    before do
      mock(subject).dimensions {"800x600"}
    end

    it "finds width by the first dimension" do
      subject.width.should == "800"
    end

    it "finds height by the last dimension" do
      subject.height.should == "600"
    end
  end
end
