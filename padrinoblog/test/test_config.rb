PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require "test/unit"

class Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    ##
    # You can handle all padrino applications using instead:
    #   Padrino.application
    PadrinoBlog::App.tap { |app|  }
  end

  def setup 
  	DatabaseCleaner.strategy = :truncation 
  	DatabaseCleaner.start 
  end

  def teardown 
  	DatabaseCleaner.clean 
	end
end
