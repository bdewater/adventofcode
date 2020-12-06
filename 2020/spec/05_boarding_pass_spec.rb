require_relative "../05_boarding_pass"

RSpec.describe BoardingPass do
  describe "part 1" do
    it do
      input = described_class.new("FBFBBFFRLR")

      expect(input.row).to eq(44)
      expect(input.column).to eq(5)
      expect(input.seat).to eq(357)
    end

    it do
      input = described_class.new("BFFFBBFRRR")

      expect(input.row).to eq(70)
      expect(input.column).to eq(7)
      expect(input.seat).to eq(567)
    end

    it do
      input = described_class.new("FFFBBBFRRR")

      expect(input.row).to eq(14)
      expect(input.column).to eq(7)
      expect(input.seat).to eq(119)
    end

    it do
      input = described_class.new("BBFFBBFRLL")

      expect(input.row).to eq(102)
      expect(input.column).to eq(4)
      expect(input.seat).to eq(820)
    end
  end
end
