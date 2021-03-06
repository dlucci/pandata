require 'optparse'
require_relative '../pandata'

module Pandata

  # Parses command-line input.
  class ArgvParser
    private_class_method :new

    # Parses an ARGV array for options.
    # @param argv [Array] an ARGV array
    # @return [Hash]
    #   - :opts [OptionParser]
    #   - :user_id [String]
    #   - :output_file [String]
    #   - :data_to_get [Array]
    #   - :get_all_data [Boolean]
    #   - :return_as_json [Boolean]
    def self.parse(argv)
      options = { data_to_get: [] }
      get_all_data = false

      options[:opts] = OptionParser.new do |opts|
        opts.banner = 'Pandata: A tool for downloading Pandora.com data (likes, bookmarks, stations, etc.)'
        opts.define_head 'Usage: pandata <email|webname> [options]'
        opts.separator <<-END

Examples:
  pandata john@example.com --liked_tracks
  pandata my_webname --all -o my_pandora_data.txt
  pandata my_webname -lLb --json

Options:
        END

        opts.on('--all', 'Get all data') do
          get_all_data = true
        end

        opts.on('-a', '--recent_activity', 'Get recent activity') do
          options[:data_to_get] << :recent_activity
        end

        opts.on('-B', '--bookmarked_artists', 'Get all bookmarked artists') do
          options[:data_to_get] << :bookmarked_artists
        end

        opts.on('-b', '--bookmarked_tracks', 'Get all bookmarked tracks') do
          options[:data_to_get] << :bookmarked_tracks
        end

        opts.on('-F', '--followers', "Get all user's followers") do
          options[:data_to_get] << :followers
        end

        opts.on('-f', '--following', 'Get all users being followed by user') do
          options[:data_to_get] << :following
        end

        opts.on('-j', '--json', 'Return the results as JSON') do
          options[:return_as_json] = true
        end

        opts.on('-L', '--liked_artists', 'Get all liked artists') do
          options[:data_to_get] << :liked_artists
        end

        opts.on('-l', '--liked_tracks', 'Get all liked tracks') do
          options[:data_to_get] << :liked_tracks
        end

        opts.on('-m', '--liked_albums', 'Get all liked albums') do
          options[:data_to_get] << :liked_albums
        end

        opts.on('-n', '--liked_stations', 'Get all liked stations') do
          options[:data_to_get] << :liked_stations
        end

        opts.on('-o', '--output_file PATH', 'File to output the data into') do |path|
          options[:output_file] = path
        end

        opts.on('-S', '--playing_station', 'Get currently playing station') do
          options[:data_to_get] << :playing_station
        end

        opts.on('-s', '--stations', 'Get all stations') do
          options[:data_to_get] << :stations
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("--version", "Show version") do
          puts Pandata::Version::STRING
          exit
        end
      end

      options[:opts].parse(argv)

      # User ID is the first argument.
      options[:user_id] = argv.shift

      if get_all_data
        options[:data_to_get] = [
          :recent_activity,
          :playing_station,
          :stations,
          :bookmarked_tracks,
          :bookmarked_artists,
          :liked_tracks,
          :liked_artists,
          :liked_albums,
          :liked_stations,
          :followers,
          :following
        ]
      else
        # Remove any duplicates caused by supplying flags multiple times.
        options[:data_to_get].uniq!
      end

      options
    end

  end
end
