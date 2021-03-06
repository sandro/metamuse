require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Metamuse::Services::Echonest do
  describe "finding an artist" do
    before do
      @query = "coldplay"
      @response = {'response' => {'artists' => {}}}
    end

    it "returns nil when no artist was found" do
      @response['response'] = {'artists' => nil}
      stub(Metamuse::Services::Echonest).get { @response}
      Metamuse::Services::Echonest.artist(@query).should be_nil
    end

    it "returns the first of a collection of artists" do
      @response['response']['artists'].merge! "artist"=>[{"name"=>"Battles", "id"=>"1"}, {"name"=>"The Battles", "id"=>"2"}]
      stub(Metamuse::Services::Echonest).get { @response}
      Metamuse::Services::Echonest.artist(@query).should be_instance_of(Metamuse::Artist)
    end

    it "returns the one matching artist" do
      @response['response']['artists'].merge! "artist"=>{"name"=>"Coldplay", "id"=>"1"}
      stub(Metamuse::Services::Echonest).get { @response}
      Metamuse::Services::Echonest.artist(@query).should be_instance_of(Metamuse::Artist)
    end
  end
end
