#!/usr/bin/env ruby
#-*-mode: Ruby; coding: utf-8;-*-
require 'time'

Maid.rules do
  RUN_TIME = Time.now
  DAY_SECONDS = 60 * 60 * 24
  WEEK = DAY_SECONDS * 7
  ONE_WEEK_AGO = (RUN_TIME - WEEK)
  TWO_WEEKS_AGO = (RUN_TIME - WEEK * 2)
  THREE_MONTHS_AGO = (RUN_TIME - (DAY_SECONDS * 93))

  # Nuke crap > say 2 weeks should be fine.
  def clean_download_dir
      dir('~/Downloads/*').each do |path|
        trash path if File.mtime(path) < TWO_WEEKS_AGO
      end
  end

  case %x/uname -s/.chomp
  when 'Darwin'
    rule '/Library/Caches/Homebrew/' do
      dir('/Library/Caches/Homebrew/*.tar.*').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
      dir('/Library/Caches/Homebrew/*.tgz').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
      dir('/Library/Caches/Homebrew/*.tbz').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
      dir('/Library/Caches/Homebrew/*.bz2').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
      dir('/Library/Caches/Homebrew/*.gz').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
      dir('/Library/Caches/Homebrew/*.xz').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
    end

    rule '~/Downloads' do
      clean_download_dir
    end

    rule '~/Library/Caches' do
      dir('~/Library/Caches/Google/Chrome/Default/Cache/*').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
      dir('~/Library/Caches/Google/Chrome/PnaclTranslationCache/*').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
      dir('~/Library/Caches/Firefox/Profiles/*.default/Cache/*').each do |path|
        trash path if File.mtime(path) < THREE_MONTHS_AGO
      end
    end
  when 'Linux'
    rule 'Clean Download dir' do
      clean_download_dir
    end
  end
end
