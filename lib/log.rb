# frozen_string_literal: true

class Log
  class << self
    DATETIME_FORMAT = "datetime_format: '%Y-%m-%d %H:%M:%S'"

    def info
      logger.info yield if logger.info?
    end

    def debug
      logger.debug yield if logger.debug?
    end

    def error
      logger.error yield if logger.error?
    end

    def warn
      logger.warn yield if logger.warn?
    end

    private

    def logger
      @logger ||= Logger.new($stdout, DATETIME_FORMAT, level: Config::LOGGER_LEVEL)
    end
  end
end
