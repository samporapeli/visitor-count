#!/usr/bin/env ruby
require 'sinatra'
require 'json'

get '/api/site/:site' do
  visit(params['site']).to_json
end

get '/js/counter.js' do
  File.read('counter.js')
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
  data[site]
end
