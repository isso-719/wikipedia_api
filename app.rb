require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'net/http'
require 'open-uri'
require 'json'

# 検索結果を取得するためのURLを生成
def url_gen_search(keyword)
    base_url = 'https://ja.wikipedia.org/w/api.php?format=json&action=opensearch&limit=3&search='
    url = URI.encode(base_url+keyword)
    url = URI.parse(url)
    return url
end

# 検索結果を取得するためのURLを生成
def url_gen_content(keyword)
    base_url = 'http://ja.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles='
    url = URI.encode(base_url+keyword)
    url = URI.parse(url)
    return url
end

# GET 404
# not_found do
#     "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby"
# end

get '/' do

    # もしkeywordクエリがあって、その中身があれば
    if params['keyword'] && !params['keyword'].empty?

        # キーワード検索する
        keyword = params['keyword']
        uri = URI(url_gen_search(keyword))
        search_json = open(uri).read
        search_result = JSON.load(search_json)

        # erbにコンテンツを返す
        @results = []
        search_result[1].each do |i|
            content_json = open(url_gen_content(i)).read
            content_result = JSON.load(content_json)

            content_result["query"]["pages"].each do |i|
                @results.push(i)
            end

        end

        erb :index

    # もしクエリの内容が不十分だった場合
    # else
    #     "We need keyword after '/?keyword=' . For example: https://wikipedia-api-net.herokuapp.com/?keyword=Ruby"

    end
end