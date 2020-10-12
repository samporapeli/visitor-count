#!/usr/bin/env ruby
require 'sinatra'
require 'json'

set :protection, :except => [:frame_options, :json_csrf]

configure do
  mime_type :javascript, 'text/javascript'
end

get '/api/site/:site' do
  content_type :json
  visit(params['site']).to_json
end

get '/js/counter.js' do
  content_type :javascript
  send_file 'counter.js'
end

get '/html/frame.html' do
  content_type :html
  send_file 'frame.html'
end

def visit(site)
  file = File.read('./data.json')
  data = JSON.parse(file)
  amount = if data.has_key? site
             data[site]['amount'] + 1
           else
             data[site] = Hash.new
             data[site]['since'] = Time.now.to_i
             1
           end
  data[site]['amount'] = amount
  File.write('./data.json', JSON.dump(data))
  print JSON.dump(data)
  data[site]
end
