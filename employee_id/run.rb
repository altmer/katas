require 'rspec/autorun'
require 'date'

class EmployeeIDValidator
  def initialize(first_name:, last_name:, employee_id:)
    @first_name = first_name&.downcase
    @last_name = last_name&.downcase
    @employee_id = employee_id&.downcase
  end

  def validate
    valid? ? 'PASS' : 'INVESTIGATE'
  end

  private

  attr_reader :first_name, :last_name, :employee_id

  def valid?
    return false if first_name.empty? || last_name.empty? || employee_id.empty?
    return false if employee_id.length < 13
    return false if first_name.length < 2
    return false if last_name.length < 2

    first_name_letters_valid? && last_name_letters_valid? && year_valid? &&
      month_valid? && employment_number_valid? && verification_digit_valid?
  end

  def first_name_letters_valid?
    employee_id[2..3] == first_name[0..1]
  end

  def last_name_letters_valid?
    employee_id[0..1] == last_name[0..1]
  end

  def year_valid?
    year = Integer(employee_id[4, 4])
    year <= Date.today.year
  rescue ArgumentError
    false
  end

  def month_valid?
    month = Integer(employee_id[8, 2])
    month >= 1 && month <= 12
  rescue ArgumentError
    false
  end

  def employment_number_valid?
    emp_number = Integer(employee_id[10..-2])
    emp_number >= 1
  rescue ArgumentError
    false
  end

  def verification_digit_valid?
    numeric_part = employee_id[4..-2]
    o = digits_sum(numeric_part, 1, 2)
    e = digits_sum(numeric_part, 0, 2)

    v = (o - e).abs % 10
    verification_digit = employee_id[-1].to_i

    v == verification_digit
  end

  def digits_sum(s, start, step)
    i = start
    res = 0
    while i < s.length
      res += s[i].to_i
      i += step
    end
    res
  end
end

RSpec.describe EmployeeIDValidator do
  subject do
    EmployeeIDValidator.new(
      first_name: first_name,
      last_name: last_name,
      employee_id: employee_id
    )
  end

  context 'basic example' do
    let(:first_name) { 'Jigarius' }
    let(:last_name) { 'Caesar' }
    let(:employee_id) { 'CAJI2o2002196' }

    it 'validates basic example correctly' do
      expect(subject.validate).to eq('PASS')
    end
  end
end



# def digits_sum(s, start, step)
#   i = start
#   res = 0
#   while i < s.length
#     res += s[i].to_i
#     i += step
#   end
#   res
# end

# employee_id = 'CAJI202002196'
# numeric_part = employee_id[4..-2]
# p numeric_part

puts "First name:\n"
first_name = gets.chomp.downcase

puts "Last name:\n"
last_name = gets.chomp.downcase

puts "Employee ID:\n"
employee_id = gets.chomp.downcase

puts EmployeeIDValidator.new(
  first_name: first_name, last_name: last_name, employee_id: employee_id
).validate


