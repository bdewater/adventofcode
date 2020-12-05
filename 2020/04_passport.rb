class Passport
  def self.parse_batch(input)
    lines = input.split("\n\n")
    lines.map { |line| parse_line(line) }
  end

  def self.parse_line(line)
    Passport.new(line.gsub("\n", " ").split(" "))
  end

  def self.check_part_1(passports)
    passports.count(&:fields_present?)
  end

  def self.check_part_2(passports)
    passports
      .select(&:fields_present?)
      .count(&:fields_valid?)
  end

  VALID_ATTRS = [:byr, :iyr, :eyr, :hgt,:hcl, :ecl, :pid, :cid].freeze
  VALID_ATTRS.each { |attr| attr_accessor(attr) }
  def initialize(pairs)
    pairs.each do |pair|
      key, value = pair.split(":")
      target = :"#{key}="
      send(target, value) if respond_to?(target)
    end
  end

  REQUIRED_ATTRS = (VALID_ATTRS - [:cid]).freeze
  def fields_present?
    REQUIRED_ATTRS.all? do |attr|
      send(attr)
    end
  end

  VALIDATORS = {
    byr: ->(input) { input.to_i.between?(1920, 2002) },
    iyr: ->(input) { input.to_i.between?(2010, 2020) },
    eyr: ->(input) { input.to_i.between?(2020, 2030) },
    hgt: ->(input) {
      /(?<number>\d+)(?<unit>cm|in)/ =~ input
      case unit
        when "cm"
          number.to_i.between?(150, 193)
        when "in"
          number.to_i.between?(59, 76)
      end
    },
    hcl: ->(input) { input.match?(/#[0-9a-f]{6}/) },
    ecl: ->(input) { %w[amb blu brn gry grn hzl oth].include?(input) },
    pid: ->(input) { input.match?(/\A\d{9}\z/) },
  }.freeze
  def fields_valid?
    REQUIRED_ATTRS.all? do |attr|
      VALIDATORS.fetch(attr).call(send(attr))
    end
  end
end

if __FILE__ == $0
  filename = "04_input.txt"
  input = File.read(filename)
  passports = Passport.parse_batch(input)
  puts "Part 1: #{Passport.check_part_1(passports)}"
  puts "Part 2: #{Passport.check_part_2(passports)}"
end

