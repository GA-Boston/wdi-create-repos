require_relative 'ask'

class AskWeek < Ask

  MAX_WEEK = 13

  def initialize(week_num = 0)
    super(week_num) # don't think I need the week_num param here?
  end
  
  def prompt
    print "What week are we in? [1..#{MAX_WEEK}]: "
  end

  def get_input
    self.input_value = gets.chomp.to_i
  end
  
  def valid?
    (1..MAX_WEEK).include?(self.input_value.to_i)
  end

  def show_error
    puts "ERROR: week number MUST be between [1..#{MAX_WEEK}]"
  end
end
