module ZombieAdmin
  class Scope
    attr_reader :resource, :name, :method, :options

    def initialize(resource, name, options = {})
      @resource = resource
      @name = name.to_s
      @method = (options.delete(:method) || name).to_sym
      @options = options
    end

    def default?
      !!@options[:default]
    end

    def human_name
      I18n.t(
        "zombie_admin.resources.#{resource.model_name.i18n_key}.filters.#{name}", 
        :default => [ :"zombie_admin.filters.#{name}", name.titleize]
      )
    end

    def display?
      return true  if options[:if].nil? || options[:if] == true
      return false if options[:if] == false
      return options[:if].call(resource)
    end
  end
end
