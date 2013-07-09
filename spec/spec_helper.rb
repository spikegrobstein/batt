require 'rubygems'
require 'bundler/setup'

$: << File.dirname(__FILE__) + '/../lib'

require 'batt'

def fixture_path(filename)
  File.join( File.dirname(__FILE__), 'fixtures', filename )
end

