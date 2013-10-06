require 'erb'

class ProcessErb
  attr_accessor :input_fname, :output_fname
  attr_accessor :erb_vars
  
  def initialize(input_fname, output_fname, erb_vars)
    self.input_fname = input_fname
    self.output_fname  = output_fname
    self.erb_vars = erb_vars
    self.create_attrs
  end

  def create_method(name, &block)
    self.class.send(:define_method, name, &block)
  end

  # create methods 
  def create_attrs
    erb_vars.each do |k, v|
      create_method(k) { v }
      end
  end

  # need this to expose private binding method
  def get_binding
    binding
  end
  
  def process
    contents = ""

    File.open(self.input_fname, 'r') do |file|
      contents = ERB.new(file.read).result(self.get_binding)
      # puts "contents =  #{contents}"
    end

    File.open(self.output_fname, 'w+') do |file|
      file.write(contents)
    end
    FileUtils.rm(self.input_fname)
  end

end
