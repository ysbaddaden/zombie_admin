require "active_admin/config"
require "active_admin/routes"
require "active_admin/resource"

module ActiveAdmin
  mattr_accessor :resources
  self.resources = {}

  module Controllers
    autoload :Responder,   "active_admin/controllers/responder"
    autoload :Application, "active_admin/controllers/application"
    autoload :Resources,   "active_admin/controllers/resources"
  end

  def self.config
    yield ActiveAdmin::Config if block_given?
    ActiveAdmin::Config
  end

  def self.load_resources!
    config.load_paths.collect { |path| Dir[path] }.flatten.each { |file| require file }
  end

  def self.register(klass, &block)
    resource = Resource.new(klass)
    ActiveAdmin::DSL.new(resource, &block)
    self.resources[resource.model_name.plural] = resource
  end

  def self.menus
    @menus ||= self.resources.values.collect(&:menu)
  end
end
