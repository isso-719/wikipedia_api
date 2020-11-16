require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'net/http'
require 'open-uri'
require 'json'

def url_gen(keyword)
    base_url = 'http://ja.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles='
    url = base_url+keyword
    return url
end

get '/:keyword' do
    @keyword = params[:keyword]
    uri = URI(url_gen(params[:keyword]))
    json_file = open(uri).read
    hash = JSON.load(json_file)
    @result = hash["query"]["pages"]["1024"]["extract"]

    erb :index


end