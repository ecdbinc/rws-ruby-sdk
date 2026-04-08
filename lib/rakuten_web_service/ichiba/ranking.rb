# frozen_string_literal: true

require 'rakuten_web_service/ichiba/item'

module RakutenWebService
  module Ichiba
    class RankingItem < RakutenWebService::Ichiba::Item
      endpoint 'https://openapi.rakuten.co.jp/ichibams/api/IchibaItem/Ranking/20260401'

      parser do |response|
        response['Items'].map { |item| RankingItem.new(item) }
      end

      attribute :rank
    end
  end
end
