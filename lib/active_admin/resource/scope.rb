module ActiveAdmin
  class Scope
    attr_reader :name, :options

    def initialize(name, method = nil, options = {})
      @name = name
      @method = method
      @options = options
    end

    def method
      (@method || name).to_sym
    end

    def display?
      return true  if options[:if].nil? || options[:if] == true
      return false if options[:if] == false
      return options[:if].call(resource)
    end
  end
end
