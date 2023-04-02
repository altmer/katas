class CheckOut
  def initialize(rules)
    @tally = {}
    @rules = rules
  end

  def scan(item)
    @tally[item] ||= 0
    @tally[item] += 1
  end

  def total
    sum = 0
    @tally.each do |item, count|
      rule = rule_for(item)
      raise "rule not found for #{item}" if rule.nil?

      sum += price(rule, count)
    end
    sum
  end

  private

  def rule_for(item)
    @rules.find { |rule| rule[:item] == item }
  end

  def price(rule, count)
    case rule[:rule]
    when 'xfory'
      per_count, special_price = rule[:values]
      ((count / per_count) * special_price) + ((count % per_count) * rule[:price])
    when 'plain'
      count * rule[:price]
    end
  end
end
