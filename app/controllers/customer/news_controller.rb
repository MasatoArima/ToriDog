class Customer::NewsController < ApplicationController
  require "open-uri"
  def index
    api = ENV['NEWS_API_KEY']
    # uri = "https://newsapi.org/v2/everything?q=%E3%83%81%E3%83%AF%E3%83%83%E3%82%AF%E3%82%B9&qInTitle=%E3%83%81%E3%83%AF%E3%83%83%E3%82%AF%E3%82%B9&sortBy=popularity&apiKey=#{api}"
    uri = "https://newsapi.org/v2/everything?q=%E6%9F%B4%E7%8A%AC&qInTitle=%E7%8A%AC&sortBy=popularity&language=jp&apiKey=#{api}"
    article_serialized = open(uri).read
    @articles = JSON.parse(article_serialized)
  end
end
