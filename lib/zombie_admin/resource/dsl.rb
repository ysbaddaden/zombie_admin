module ZombieAdmin
  class DSL
    attr_reader :resource

    def initialize(resource, &block)
      @resource = resource
      instance_eval(&block)
    end

    def scope(name, options = {})
      @resource.scopes.add(name, options)
    end

    def menu(options)
      options = { :if => false } if options == false
      options = {} if options == true
      @resource.menu = Menu.new(self, options)
    end

    def actions(*args)
      @resource.actions = args
    end

    def filter(column_name)
      @resource.filters << column_name
    end

    def member_action(name, options = {}, &block)
      method = options[:method] || :get
      @resource.member_actions[name] = Action.new(method.to_sym, name, &block)
    end

    def collection_action(name, options = {}, &block)
      method = options[:method] || :get
      @resource.collection_actions[name] = Action.new(method.to_sym, name, &block)
    end
  end
end
