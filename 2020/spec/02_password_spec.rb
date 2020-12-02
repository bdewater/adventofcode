require_relative "../02_password"

RSpec.describe Password do
  INPUT = <<~EOS
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
  EOS

  describe ".old_policy" do
    it do
      expect(described_class.old_policy(INPUT)).to eq(2)
    end
  end

  describe ".new_policy" do
    it do
      expect(described_class.new_policy(INPUT)).to eq(1)
    end
  end
end
