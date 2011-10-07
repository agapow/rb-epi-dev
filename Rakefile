require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require 'yard'
require './lib/relais-dev'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'epi-dev' do
  self.developer 'Paul-Michael Agapow', 'paul-michael.agapow@hpa.org.uk'
  self.post_install_message = 'PostInstall.txt' 
  self.rubyforge_name       = self.name 
  # self.extra_deps         = [['activesupport','>= 2.0.2']]

end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']   # optional
  t.options = ['--any', '--extra', '--opts'] # optional
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]
