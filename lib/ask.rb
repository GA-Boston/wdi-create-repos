class Ask
  attr_accessor :input_value
  
  def initialize(input_value = nil)
    @input_value = input_value
  end
  
  def ask
    while !valid?
      prompt
      get_input
      show_error unless valid?
    end
    self.input_value
  end

end
