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

get '/api/site/:site/view-only' do
  content_type :json
  site_data = get_dict()[params['site']]
  if site_data.nil?
    Hash['amount' => 0, 'since' => nil].to_json
  else
    site_data.to_json
  end
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
  data = get_dict()
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

def get_dict()
  file = File.read('./data.json')
  JSON.parse(file)
end
