# simple class to error handling
class Error < RuntimeError
  attr_reader :message

  def initialize(error_message)
    @message = error_message
  end
end
