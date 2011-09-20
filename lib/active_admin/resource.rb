require "zombie_admin/resource/dsl"
require "zombie_admin/resource/scope"
require "zombie_admin/resource/menu"

module ZombieAdmin
  class Action
    attr_reader :method, :name, :block

    def initialize(method, name, &block)
      @method = method
      @name   = name
      @block  = block
    end
  end

  class Resource
    attr_reader   :klass
    attr_writer   :menu
    attr_accessor :actions, :member_actions, :collection_actions, :scopes, :filters

    delegate :model_name, :to => :klass

    def initialize(klass)
      @klass = klass
      @actions = [ :index, :show, :new, :edit, :create, :update, :destroy ]
      @member_actions = {}
      @collection_actions = {}
      @scopes = []
      @filters = []
      build_controller
    end

    def menu
      @menu ||= Menu.new(self)
    end

    def controller
      @controller ||= ("::Admin::" + controller_name.camelize + "Controller").constantize
    end

    def controller_name
      @controller_name ||= model_name.plural
    end

    protected
      def build_controller
        eval <<-EOV
          module ::Admin
            class #{controller_name.camelize}Controller < ::ZombieAdmin::Controllers::Resources
            end
          end
        EOV
      end
  end
end
