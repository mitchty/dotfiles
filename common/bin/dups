#!/usr/bin/env ruby
#
# Quick script to find duplicate files
#

require 'find'
require 'digest/sha1'
require 'set'

hashes = Hash.new
start = ARGV[0] || ENV["HOME"]
puts "Building digests from #{start}"

Find.find(start) do |path|
  STDOUT.flush
  this_hash = Set.new
  hash = "NONE"
  if (FileTest.directory?(path) or FileTest.symlink?(path)\
      or FileTest.blockdev?(path) or FileTest.chardev?(path)\
      or FileTest.socket?(path) or FileTest.pipe?(path)\
      or FileTest.zero?(path)) then
    next
  else
  begin
    file_digest = Digest::SHA1.new
    File.open(path, 'r') do |fh|
      while buffer = fh.read(8096)
        file_digest.update(buffer)
      end
    end
    hash = file_digest.hexdigest
  rescue NoMemoryError
    puts "NoMemoryError on #{path}"
    GC.start
  rescue IOError
    puts "IOError on #{path}"
    GC.start
  rescue Errno::ENOSYS; next
  rescue Errno::EACCES; next
  rescue Errno::EINVAL; next
  rescue => e
    puts "Unhandled error on #{path}, exception #{e}"
    p e
    exit 255
  end
  end
  if (hashes[hash]) then
    hashes[hash].add(path)
  else
    hashes[hash] = this_hash.add(path)
  end
end

puts "Digest generation complete."
hashes.each_pair do |key, val|
  files = val.to_a
  files.delete(nil)
  files.delete_if {|x| "#{x}" =~ /^\s*$/}
  next if (files.size < 2)
  puts "Duplicate digest <#{key}> for files:\n  #{files.join("\n  ")}"
end
