# frozen_string_literal: true

require 'getoptlong'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

def show_help(status = 0)
  puts <<~HELP
  Usage: #{__FILE__} [OPTIONS] USERNAME
  Options:
    --help, -h      Show this help message
  Arguments:
    USERNAME        Your GitHub username
  HELP
  exit(status)
end

options = GetoptLong.new(
  ['--help', '-h', GetoptLong::NO_ARGUMENT]
)

options.each do |option, _|
  case option
  when '--help'
    show_help
  end
end

if ARGV.length.zero?
  puts "Error: You need to pass your GitHub's username (see --help)."
  exit(1)
end

username = ARGV[0]

uri = URI.parse("https://api.github.com/users/#{username}/repos")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

response = http.request(Net::HTTP::Get.new(uri.request_uri))

unless response.code == '200'
  puts "Error: Got a HTTP error code (#{response.code}). Seek help online."
  exit(1)
end

json_response = JSON.parse(response.body)

puts "Following are all #{username} user repositories"
json_response.each_with_index do |repo, index|
  puts "#{index + 1} - #{repo['name']}"
end

print 'Enter the numbers of the repositories you want to clone or type "all" to clone all: '
repos_indexes = $stdin.gets.chomp.split

choice = repos_indexes[0] == 'all' ? 'all' : repos_indexes

if choice == 'all'
  json_response.each do |repo|
    puts '|---------------------------|'
    puts "Cloning #{repo['name']}..."
    system("git clone #{repo['ssh_url']} --quiet")
    puts "Finished cloning of #{repo['name']} repository"
  end
else
  indexes_list.each do |repo_index|
    repo_index = repo_index.to_i - 1
    puts '|---------------------------|'
    puts "Cloning #{json_response[repo_index]['name']}..."
    system("git clone #{json_response[repo_index]['ssh_url']} --quiet")
    puts "Finished cloning of #{json_response[repo_index]['name']} repository"
  end
end

puts '|---------------------------|'
