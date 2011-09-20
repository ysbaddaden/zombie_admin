require "zombie_admin/config"
require "zombie_admin/routes"
require "zombie_admin/resource"
require "formtastic"

module ZombieAdmin
  mattr_accessor :resources
  self.resources = {}

  module Controllers
    autoload :Responder,   "zombie_admin/controllers/responder"
    autoload :Application, "zombie_admin/controllers/application"
    autoload :Resources,   "zombie_admin/controllers/resources"
  end

  def self.config
    yield ZombieAdmin::Config if block_given?
    ZombieAdmin::Config
  end

  def self.load_resources!
    config.load_paths.collect { |path| Dir[path] }.flatten.each { |file| require file }
  end

  def self.register(klass, &block)
    resource = Resource.new(klass)
    ZombieAdmin::DSL.new(resource, &block)
    self.resources[resource.model_name.plural] = resource
  end

  def self.menus
    @menus ||= self.resources.values.collect(&:menu)
  end
end
