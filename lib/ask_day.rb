require_relative 'ask'

class AskDay < Ask

  MAX_DAY = 5

  def initialize(day_num = nil)
    super(day_num) # don't think I need the day_num param here?
  end
  
  def prompt
    print "What day are we in? [1..#{MAX_DAY}]: "
  end

  def get_input
    self.input_value = gets.chomp.to_i
  end
  
  def valid?
    (1..MAX_DAY).include?(self.input_value.to_i)
  end

  def show_error
    puts "ERROR: day number MUST be between [1..#{MAX_DAY}]"
  end
end
