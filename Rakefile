require_relative 'boot.rb'

Dir.glob('tasks/*.rake').each { |file| import file }

desc "Start the application"
task :start do
  exec 'rackup -s Puma --host=0.0.0.0 --port=4567'
end

desc "Run the application in production enviroment"
task :run do
  exec 'RACK_ENV=production rackup -s Puma --host=0.0.0.0 --port=4567'
end

desc "Boots up the application in irb console."
task :console do
  require 'irb'
  begin
    require "irb/completion"
  rescue LoadError
  end
  ARGV.clear
  IRB.start
end
