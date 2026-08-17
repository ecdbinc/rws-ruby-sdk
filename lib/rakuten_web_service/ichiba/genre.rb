# frozen_string_literal: true

require 'rakuten_web_service/genre'
require 'rakuten_web_service/ichiba/ranking'
require 'rakuten_web_service/ichiba/product'

module RakutenWebService
  module Ichiba
    class Genre < RakutenWebService::BaseGenre
      endpoint 'https://openapi.rakuten.co.jp/ichibagt/api/IchibaGenre/Search/20260701'

      attribute :genreId, :nameJa, :level

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

      # 新レスポンスでは parents / brothers が ancestors / siblings という名前で返るため、
      # BaseGenre の実装をキー名だけ差し替えて上書きする
      def parents
        @params['ancestors'] ||= self.class.search(self.class.genre_id_key => id).first.parents
      end

      def brothers
        @params['siblings'] ||= self.class.search(self.class.genre_id_key => id).first.brothers
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
