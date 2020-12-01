require_relative "../01a_report"

RSpec.describe Report do
  INPUT = <<~EOS
    1721
    979
    366
    299
    675
    1456
  EOS

  describe ".multiply" do
    it do
      expect(described_class.multiply(INPUT, 2)).to eq(514579)
    end

    it do
      expect(described_class.multiply(INPUT, 3)).to eq(241861950)
    end
  end
end
