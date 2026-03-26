# frozen_string_literal: true

module RakutenWebService
  class Error < StandardError
    def self.register(status_code, error)
      repository[status_code] = error
    end

    def self.for(response)
      error_class = repository[response.code.to_i] || Error
      body = JSON.parse(response.body)
      message = body['error_description'] || body.dig('errors', 'errorMessage')
      error_class.new(message)
    end

    def self.repository
      @repository ||= {}
    end
  end

  class WrongParameter < Error; end
  Error.register(400, WrongParameter)

  class Forbidden < Error; end
  Error.register(403, Forbidden)

  class NotFound < Error; end
  Error.register(404, NotFound)

  class TooManyRequests < Error; end
  Error.register(429, TooManyRequests)

  class SystemError < Error; end
  Error.register(500, SystemError)

  class ServiceUnavailable < Error; end
  Error.register(503, ServiceUnavailable)
end
