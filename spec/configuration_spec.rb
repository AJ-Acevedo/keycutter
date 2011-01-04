require File.dirname(__FILE__) + '/spec_helper.rb'

describe Gem::ConfigFile do
  before do
    @credentials = File.dirname(__FILE__) + '/../test_credentials'
    @config = Gem::ConfigFile.new([])
    @config.stub(:credentials_path) { @credentials }
  end

  describe "#api_keys" do
    it "should load from credentials file" do
      credentials = {'personal' => '1'*32, 'work' => '2'*32}
      File.open(@credentials, 'w') { |f| f.write credentials.to_yaml }
      @config.api_keys.should == credentials
    end
  end

  describe "#api_keys=" do
    it "should write to credentials file" do
      File.open(@credentials, 'w') { |f| f.write '' }
      accounts = {'personal' => '1'*32, 'work' => '2'*32}
      @config.api_keys = accounts

      File.read(@credentials).should == accounts.to_yaml
    end

    it "should preserve existing credentials" do
      api_key = {:rubygems_api_key => '0'*32}
      File.open(@credentials, 'w') { |f| f.write api_key.to_yaml }

      accounts = {'personal' => '1'*32, 'work' => '2'*32}
      @config.api_keys = accounts

      credentials = YAML.load_file(@credentials)
      credentials[:rubygems_api_key].should == '0'*32
    end
  end
end
