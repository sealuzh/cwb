describe HashExtension do
  let(:hash) {
  {
    "webserver" => {
      "users" => {
        "admin" => {
          "password" => "some amazing password"
          }
        }
      }
    }
  }

  describe "#deep_fetch" do
    it "returns the correct value for the provided keys" do
      expect(hash.deep_fetch("webserver","users","admin","password")).to eq("some amazing password")
    end
    it "raises KeyError if the provided keys do not exist" do
      expect{ hash.deep_fetch("webserver","users","jdoe","password") }.to raise_error(KeyError)
    end
    it "returns the provided default value if the key does not exist" do
      expect(hash.deep_fetch("webserver","users","jdoe","password", default: "Key Missing")).to eq("Key Missing")
    end
    it "returns the provided default value if the key does not exist" do
      expect(hash.deep_fetch("webserver","users","jdoe","password", default: false)).to be false
    end
  end

  describe "#fetch_keypath" do
    it "returns the correct value for the provided keypath" do
      expect(hash.fetch_keypath("webserver.users.admin.password")).to eq("some amazing password")
    end
    it "raises KeyError if the provided keys do not exist" do
      expect { hash.fetch_keypath("webserver.users.jdoe.password") }.to raise_error(KeyError)
    end
    it "returns the provided default value if the key does not exist" do
      expect(hash.fetch_keypath("webserver.users.jdoe.password", default: "Key Missing")).to eq("Key Missing")
    end
  end
end
