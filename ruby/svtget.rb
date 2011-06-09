#!/usr/bin/env ruby

require 'optparse'
require "net/http"
require 'uri'

# Available bitrates at svtplay
bitrate = {:l => 320, :m => 850, :n => 1400, :h => 2400}
options = {}

# Set default bitrate
options[:bitrate] = bitrate[:n]

# Options
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: svtplay.rb [options] URL"

  opts.on("-l", "--low", "Low quality") do
    options[:bitrate] = bitrate[:l]
  end

  opts.on("-m", "--medium", "Medium quality") do
    options[:bitrate] = bitrate[:m]
  end

  opts.on("-n", "--normal", "Normal quality") do
    options[:bitrate] = bitrate[:n]
  end

  opts.on("-h", "--high", "High quality") do
    options[:bitrate] = bitrate[:h]
  end

  opts.on("--help", "Show this help") do
    puts opts
    exit
  end

end

optparse.parse!

# Check if SVT play URL was given, else DIE!
if !ARGV[0].nil? && ARGV[0].match(/svtplay\.se/)

  # Get the HTML of the URL supplied 
  html = Net::HTTP.get URI.parse(ARGV[0])

  # Parse rtmp streams and bitrate
  streams = html.scan(/(rtmp[e]?:[^|&]+),bitrate:([0-9]+)/m)

  # Find the swf player
  player = "http://svtplay.se" + html.scan(/data="([^"]+.swf)/).to_s

  # Selecting best available stream based on availablity and user selection
  stream_bitrates = streams.collect{|s| s.last.to_i}.uniq.sort
  stream_bitrate = 0
  bitrate.values.sort.reverse.each do |b|
    if options[:bitrate] >= b
      if stream_bitrates.include?(b)
        stream_bitrate = b
        break
      end
    end
  end

  # Informing the download quality
  if(options[:bitrate] > stream_bitrate)
    puts "#{options[:bitrate]}kbs is not available, downloading #{stream_bitrate}kbs stream...\n"
  elsif options[:bitrate] == stream_bitrate
    puts "Downloading #{stream_bitrate}kbs stream...\n"
  end

  # Find stream with correct bitrate
  stream = streams.rassoc(stream_bitrate.to_s)

  # Default fileextension
  extension = ".mp4"

  # If not mp4 set .flv
  extension = ".flv" if(!(stream[0] =~ /mp4/))

  # Start downloading the stream
  system("rtmpdump -r #{stream[0]} -W #{player} -o #{stream[0].split("/").last + extension}")

else
  puts "You must supply a SVT play URL..."
  puts optparse
  exit
end


