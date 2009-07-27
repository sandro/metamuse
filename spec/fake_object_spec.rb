require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class FakeTestContext
  include FakeObject
  def stub(*args)
  end
end

describe FakeObject do

  context "#fake" do
    before do
      @context = FakeTestContext.new
    end

    it "sets the context when setting expectations" do
      mock(FakeObject::Fake).new(:greeting => 'hi')
      @context.fake(:greeting => 'hi')
    end
  end

  describe Fake do
    context "#new with no expectations" do
      it "returns a fake object" do
        FakeObject::Fake.new.should be_instance_of(Fake)
      end

      it "has a string for a name" do
        f = FakeObject::Fake.new 'fake'
        f.__name__.should == 'fake'
      end

      it "has a symbol for a name" do
        f = FakeObject::Fake.new :fake
        f.__name__.should == :fake
      end
    end

    context "#new with expectations" do
      it "responds to fake method 'greeting'" do
        f = FakeObject::Fake.new :greeting => 'hi'
        f.greeting.should == 'hi'
      end

      it "responds to its name" do
        f = FakeObject::Fake.new 'Greeter', :greeting => 'hi'
        f.__name__.should == 'Greeter'
      end

      it "doesn't conflict with a stub for 'strategy'" do
        f = FakeObject::Fake.new({:strategy => :run}, :strategy => :mock)
        f.strategy.should == :run
      end

      it "uses the mock build strategy" do
        f = FakeObject::Fake.new({:greeting => 'hi'}, :strategy => :mock)
        f.greeting
        f.__strategy__.should == :mock
      end
    end

    context "Hash not provided" do
      it "raises ArgumentError for an array" do
        expect {
          FakeObject::Fake.new []
        }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError for a name and array" do
        expect {
          FakeObject::Fake.new 'name', []
        }.to raise_error(ArgumentError)
      end
    end
  end
end
