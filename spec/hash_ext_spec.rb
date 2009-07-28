require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hash do
  describe "#rename_key" do
    subject { {:name => 'mel'} }

    it "renames name to firstname" do
      subject.rename_key(:name, :firstname)[:firstname].should == 'mel'
    end

    it "removes the name key from the hash" do
      subject.rename_key(:name, :firstname).should_not have_key(:name)
    end

    it "does not mutate the original hash" do
      subject.rename_key(:name, :firstname)
      subject[:name].should == 'mel'
      subject.should_not have_key(:firstname)
    end
  end

  describe "#rename_key!" do
    subject { {:name => 'mel'} }

    it "mutates the original hash" do
      subject.rename_key!(:name, :firstname)
      subject[:firstname].should == 'mel'
      subject.should_not have_key(:name)
    end
  end

  describe "#rename_keys" do
    subject { {:name => 'mel', :number => 123} }

    it "renames multiple keys" do
      h = subject.rename_keys(:name => :account_name, :number => :account_number)
      h[:account_name].should == 'mel'
      h[:account_number].should == 123
    end

    it "removes the original keys" do
      h = subject.rename_keys(:name => :account_name, :number => :account_number)
      h.should_not have_key(:name)
      h.should_not have_key(:number)
    end
  end

  describe "#rename_keys!" do
    subject { {:name => 'mel', :number => 123} }

    it "mutates the hash with the renamed keys" do
      subject.rename_keys!(:name => :account_name, :number => :account_number)
      subject[:account_name].should == 'mel'
      subject[:account_number].should == 123
      subject.should_not have_key(:name)
      subject.should_not have_key(:number)
    end
  end
end
