#module ZombieAdmin
#  class Naming
#    attr_reader :name
#    delegate :singular, :plural, :route_key, :param_key, :i18n_key, :to => :name

#    def initialize(model_name)
#      name = model_name
#    end

#    def underscore
#      to_s.underscore
#    end

#    def camelize
#      to_s.camelize
#    end

#    def human(options = {})
#      options[:scope] = "zombie_admin.resources"
#      I18n.t(name.i18n_key, options)
#    end

#    def to_s
#      name.to_s
#    end
#  end
#end
