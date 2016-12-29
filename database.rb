SiteConfig = Hashie::Mash.new TOML.load_file(File.join(__dir__, "config", "#{RACK_ENV}.toml"))

mongo_configuration = case RACK_ENV.to_sym
  when :development then
  {
    clients: {
      default: {
        hosts: [SiteConfig.MongoDB.host],
        database: SiteConfig.MongoDB.database
      }
    }
  }
  when :production then
  {
    clients: {
      default: {
        hosts: [SiteConfig.MongoDB.host],
        database: SiteConfig.MongoDB.database,
        options: {user: ENV["dbUser"], password: ENV["dbPassword"]}
      }
    }
  }
end

Mongoid.logger.level = Logger::INFO
Mongo::Logger.logger.level = Logger::INFO
Mongoid.raise_not_found_error = false

Mongoid::Config.load_configuration(mongo_configuration)
