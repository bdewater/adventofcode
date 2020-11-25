require_relative "../skeleton"

RSpec.describe Skeleton do
  describe ".greet" do
    it do
      expect(described_class.greet).to eq("Hello world 🏴‍☠️")
    end
  end
end
