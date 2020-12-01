require_relative "../01b_report"

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
      expect(described_class.multiply(INPUT)).to eq(241861950)
    end
  end
end
