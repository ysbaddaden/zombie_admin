module ZombieAdmin
  module Config
    mattr_accessor :site_name

    def self.load_paths
      @load_paths ||= [ Rails.root.join('app', 'admin', '**', '*.rb').to_s ]
    end
  end
end
