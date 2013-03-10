# encoding: utf-8

require_relative 'pandata/data_urls'
require_relative 'pandata/downloader'
require_relative 'pandata/parser'
require_relative 'pandata/scraper'

module Pandata
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 0
    BUILD = 'pre'

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
end

