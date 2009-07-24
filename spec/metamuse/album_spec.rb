require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Metamuse::Album do
  describe "#<=>" do
    context "comparing nil ranks" do
      before do
        @nil1 = Metamuse::Album.new :rank => nil
        @nil2 = Metamuse::Album.new :rank => nil
        @album1 = Metamuse::Album.new(:rank => 1)
        @album3 = Metamuse::Album.new(:rank => 3)
        @album5 = Metamuse::Album.new(:rank => 5)
      end

      it "moves the nil from the beginning to the end" do
        collection = [@nil1, @album5, @album1, @album3]
        collection.sort.should == [@album1, @album3, @album5, @nil1]
      end

      it "leaves the nil at the end" do
        collection = [@album5, @album1, @album3, @nil1]
        collection.sort.should == [@album1, @album3, @album5, @nil1]
      end

      it "moves the nil from the middle to the end" do
        collection = [@album5, @album1, @nil1, @album3]
        collection.sort.should == [@album1, @album3, @album5, @nil1]
      end

      it "moves both nils to the end" do
        collection = [@nil2, @album5, @album1, @nil1, @album3]
        collection.sort.should == [@album1, @album3, @album5, @nil1, @nil2]
      end
    end
  end
end
