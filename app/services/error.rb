# simple class to error handling
class Error < RuntimeError
  attr_reader :message

  def initialize(error_message)
binding.pry
    @message = error_message
  end
end
