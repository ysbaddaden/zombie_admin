module ZombieAdmin
  class Scopes < Array
    attr_reader :resource, :default_scope

    def initialize(*args)
      @resource = args.shift
      super(*args)
    end

    def add(name, options = {})
      scope = Scope.new(resource, name, options)
      self << scope
      @scopes ||= {}
      @scopes[name] = scope
      @default_scope = scope if scope.default?
    end

    def find(name)
      @scopes[name] unless @scopes.nil?
    end
  end
end
