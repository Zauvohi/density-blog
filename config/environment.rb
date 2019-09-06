# Load the Rails application.
require_relative 'application'

Rails.logger = Logger.new(STDOUT)
config.logger = ActiveSupport::Logger.new("shared/logs/#{Rails.env}.log")
# Initialize the Rails application.
Rails.application.initialize!
