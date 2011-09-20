require "zombie_admin/resource/dsl"
require "zombie_admin/resource/scopes"
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
      @scopes = Scopes.new(self)
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

    def index_columns
      @index_columns || default_columns
    end

    def show_columns
      @show_columns || default_columns
    end

    def form_columns
      @form_columns || default_columns
    end

    def default_columns
      klass.column_names
    end

    def human_link(name, options = {})
      options[:model_name] = model_name.human
      options[:default] = :"zombieadmin.links.#{name}"
      I18n.t("#{i18n_scope}.links.#{name}", options)
    end

    def i18n_scope
      "zombieadmin.resources.#{model_name.i18n_key}"
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
