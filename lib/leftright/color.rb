# This is just here to avoid depending on Term::ANSIColor and such, since
# we need so little, and need it to transparently do nothing when
# STDOUT is not a terminal.

module LeftRight
  module C
    def self.color(string = nil, code = nil)
      if ::LeftRight::tty?
        string.nil? ? "\e[#{code}m" : "\e[#{code}m" + string + "\e[0m"
      else
        string || ''
      end
    end

    def self.reset(string = nil)
      color string, 0
    end

    def self.bold(string = nil)
      color string, 1
    end

    def self.red(string = nil)
      color string, 31
    end

    def self.green(string = nil)
      color string, 32
    end

    def self.yellow(string = nil)
      color string, 33
    end

    def self.cyan(string = nil)
      color string, 36
    end
  end
end