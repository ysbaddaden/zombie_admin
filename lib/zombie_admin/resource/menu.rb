module ZombieAdmin
  class Menu
    attr_reader :resource, :options

    def initialize(resource, options = {})
      @resource = resource
      @options  = options
    end

    def title
      I18n.t(resource.model_name.i18n_key, :scope => 'zombie_admin.menus',
        :default => resource.model_name.human.pluralize)
    end

    def display?
      return true  if options[:if].nil? || options[:if] == true
      return false if options[:if] == false
      return options[:if].call(resource)
    end
  end
end
