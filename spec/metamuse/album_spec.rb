require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Metamuse::Album do
  subject { Metamuse::Album }

  describe "#<=>" do
    context "comparing nil ranks" do
      before do
        @nil1   = subject.new :rank => nil
        @nil2   = subject.new :rank => nil
        @album1 = subject.new :rank => 1
        @album3 = subject.new :rank => 3
        @album5 = subject.new :rank => 5
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

  describe "#hash" do
    it "hashes based on the artist and album name" do
      artist = Metamuse::Artist.new :name => 'Radiohead'
      album = subject.new :name => 'In Rainbows', :artist => artist
      album.hash.should == [artist, 'In Rainbows'].hash
    end
  end

  describe "#eql?" do
    it "evaluates equality by name" do
      album1 = subject.new :name => 'In Rainbows'
      album2 = subject.new :name => 'In Rainbows'
      album1.should eql(album2)
    end
  end

  describe "a unique set of albums" do
    before do
      @album1 = subject.new :name => 'In Rainbows'
      @album2 = subject.new :name => 'Hail to the Thief'
      @album3 = subject.new :name => 'In Rainbows'
    end

    it "removes the duplicate album name from the set" do
      albums = [@album1, @album2, @album3]
      albums.uniq.should == [@album1, @album2]
    end
  end
end
