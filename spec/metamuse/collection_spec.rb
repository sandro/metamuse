require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class TestShoe
  extend Metamuse::Collection
  attr_accessor :color
  def initialize(attrs={})
    attrs.each {|k,v| send(:"#{k}=", v)}
  end
end

class TestPerson
  extend Metamuse::Collection
end

describe Metamuse::Collection do
  it "creates a shoes accessor which returns an array" do
    TestPerson.send(:has_many, :shoes, TestShoe)
    TestPerson.new.shoes.should be_kind_of(Array)
  end

  describe "adding shoes to the test person" do
    before do
      TestPerson.send(:has_many, :shoes, TestShoe)
      @person = TestPerson.new
    end

    it "adds a single red shoe" do
      expect {
        @person.shoes << {:color => "red"}
      }.to change{@person.shoes.size}.by(1)
    end

    it "creates a new shoe when not appending a TestShoe" do
      shoe = stub
      TestShoe.should_receive(:new).with({:color => 'red'}).and_return(shoe)
      @person.shoes << {:color => "red"}
      @person.shoes.last.should == shoe
    end

    it "appends a TestShoe" do
      @person.shoes << TestShoe.new(:color => "red")
      @person.shoes.last.should be_instance_of(TestShoe)
    end

    it "appends many shoes" do
      @person.shoes << [TestShoe.new(:color => "red"), {:color => "blue"}]
      @person.shoes.size.should == 2
      @person.shoes.map {|s| s.class}.uniq.should == [TestShoe]
    end

    it "appends shoes when setting the collection" do
      @person.shoes.should_receive(:<<).with({:color => 'red'})
      @person.shoes = {:color => 'red'}
    end
  end

  describe "TestShoe belongs to a TestPerson" do
    before do
      TestShoe.send(:belongs_to, :person, TestPerson)
      TestPerson.send(:has_many, :shoes, TestShoe)
      @person = TestPerson.new
    end

    it "sets the shoe's person equal to the person that added the shoe" do
      @person.shoes << {:person => @person}
      @person.shoes.last.person.should == @person
    end
  end
end
