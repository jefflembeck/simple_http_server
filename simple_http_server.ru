#!/usr/bin/env rackup
#\ -E deployment

use Rack::ContentLength

# This is the present directory you're running this in
@root = Dir.pwd

run Proc.new { |env|
  # Extract the requested path from the request
  path = Rack::Utils.unescape(env['PATH_INFO'])
  index_file = @root + "#{path}index.html"

  if File.exists?(index_file)
    # Return the index
    [200, {'Content-Type' => 'text/html'}, File.readlines(index_file)]
  else
    # Pass the request to the directory app
    Rack::Directory.new(@root).call(env)
  end
}

