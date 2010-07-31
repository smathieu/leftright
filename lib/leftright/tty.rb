module LeftRight
  # Are we running under a terminal?
  def self.tty?
    STDOUT.tty?
  end
end