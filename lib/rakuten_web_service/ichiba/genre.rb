# frozen_string_literal: true

require 'rakuten_web_service/genre'
require 'rakuten_web_service/ichiba/ranking'
require 'rakuten_web_service/ichiba/product'

module RakutenWebService
  module Ichiba
    class Genre < RakutenWebService::BaseGenre
      endpoint 'https://openapi.rakuten.co.jp/ichibagt/api/IchibaGenre/Search/20260401'

      attribute :genreId, :nameJa, :level, :itemCount

      root_id 0

      parser do |response|
        current = response['genre']
        %w[children ancestors siblings].each do |type|
          elements = Array(response[type]).map { |e| Genre.new(e) }
          current.merge!(type => elements)
        end
        genre = Genre.new(current)
        [genre]
      end

      def name
        @params['nameJa']
      end

      def ranking(options = {})
        options = options.merge(genre_id: id)
        RakutenWebService::Ichiba::RankingItem.search(options)
      end

      def products(options = {})
        options = options.merge(genre_id: id)
        RakutenWebService::Ichiba::Product.search(options)
      end
    end
  end
end
