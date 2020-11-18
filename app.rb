require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'net/http'
require 'open-uri'
require 'json'

def url_gen(keyword)
    base_url = 'https://ja.wikipedia.org/w/api.php?format=json&action=opensearch&limit=3&search='
    url = URI.encode(base_url+keyword)
    url = URI.parse(url)
    return url
end

not_found do
    "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby"
end

get '/' do
    if params['keyword'] && !params['keyword'].empty?
        keyword = params['keyword']
        uri = URI(url_gen(keyword))
        json_file = open(uri).read
        hash = JSON.load(json_file)
        @results = []
        hash[1].each do |i|
            base_url = 'http://ja.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles='
            url = URI.encode(base_url+i)
            url = URI.parse(url)
            json_file_2 = open(url).read
            hash_2 = JSON.load(json_file_2)
            hash_2["query"]["pages"].each do |i|
                @results.push(i)
            end
        end

        erb :index

    else
        "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby"

    end
end