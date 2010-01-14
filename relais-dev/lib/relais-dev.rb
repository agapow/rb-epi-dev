$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Relais
	module Dev
		VERSION = '0.0.2'
	end
end

require 'relais-dev/io'