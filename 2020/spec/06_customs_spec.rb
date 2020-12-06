require_relative "../06_customs"

RSpec.describe Customs do
  let(:input) do
    <<~EOS
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
    EOS
  end

  describe "part 1" do
    it do
      expect(described_class.check_part_1(input)).to eq(11)
    end
  end

  describe "part 2" do
    it do
      expect(described_class.check_part_2(input)).to eq(6)
    end
  end
end
