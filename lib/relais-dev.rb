$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# The module that contains everything Sass-related:
#
# * {Sass::Engine} is the class used to render Sass within Ruby code.
# * {Sass::Plugin} is interfaces with web frameworks (Rails and Merb in
# particular).
# * {Sass::SyntaxError} is raised when Sass encounters an error.
# * {Sass::CSS} handles conversion of CSS to Sass.
#
# Also see the {file:SASS_REFERENCE.md full Sass reference}.

module Relais
	module Dev
		VERSION = '0.0.2'
	end
end

require 'relais-dev/common'
require 'relais-dev/io'
require 'relais-dev/text'
require 'relais-dev/simplelog'
require 'relais-dev/cli'

