#!/usr/bin/env ruby

require 'rubygems'
require 'sqlite3'

file = File.expand_path("~/Library/Application Support/Plex/userdata/Database/MyVideos34.db")

db = SQLite3::Database.new( file )

db.execute("select idshow, c10, c00 from tvShow").each do |row|
  if row[1] =~ /all\/\.zip<\/url/
    db.execute("update tvShow set c10 = ? where idshow = ?",
      row[1].gsub(/all\/\.zip</, 'all/en.zip<'),
      row[0]
    )
    puts "#{row[2]} fixed"
    
  else
    puts "#{row[2]} ok"
  end
end