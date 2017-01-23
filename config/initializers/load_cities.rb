# File for nearby cities project. 
# This file will load, when server starts up, the whole cities file and will keep it in memory.
# Data will kept in a hash in a config variable. Al least in this very first version. It would probably need to be moved to a proper place like memcache or a database table.
require 'json'
require 'net/http'

class CitiesLoader
	def initialize
		@file = "https://gist.githubusercontent.com/manuel-alvarez/20a7e013765a4361de9c3ae621a7efe2/raw/0ee93d11990f1291fd14ac2773935d7c0269f941/cities-of-the-world"
		puts "CitiesLoader initialized"
	end

	def load
		#TODO: That needs to be done. This is only a fake list
		fake_list = ["needs", "to", "be", "done"]
		uri = URI(@file)
		puts "Loading file #{@file}"
		response = Net::HTTP.get(uri)
		@cities = JSON[response]
	end
end

cities_loader = CitiesLoader.new
Rails.application.config.cities = cities_loader.load  # Load returns a hash with all the cities

puts "That's all"  # Now we know that everything went right
