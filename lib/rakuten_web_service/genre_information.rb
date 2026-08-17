# frozen_string_literal: true

module RakutenWebService
  class GenreInformation
    attr_reader :parent, :current, :children

    def initialize(params, genre_class)
      parent, current, children =
        if params.key?('genre')
          new_format(params)
        else
          old_format(params)
        end

      @parent = parent && genre_class.new(parent)
      @current = current && genre_class.new(current)
      @children = children.map { |child| genre_class.new(child) }
    end

    private

    # Ichiba (20260701 以降): ancestors / genre / children、children は直接ジャンルが並ぶ。
    # ancestors はルートから近い順に並ぶため、直近の親は末尾。
    def new_format(params)
      [Array(params['ancestors']).last, params['genre'], Array(params['children'])]
    end

    # Books / Kobo: parent / current は 1 要素の配列、children は 'child' で包まれる。
    def old_format(params)
      [
        Array(params['parent']).first,
        Array(params['current']).first,
        Array(params['children']).map { |child| child['child'] }
      ]
    end
  end
end
