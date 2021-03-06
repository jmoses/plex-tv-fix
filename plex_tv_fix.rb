#!/usr/bin/env ruby

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

require 'rubygems'
require 'sqlite3'
require 'fileutils'

BASE_PATH = File.expand_path("~/Library/Application Support/Plex/userdata/Database/")

file = "MyVideos34.db"

FileUtils.cp( File.join( BASE_PATH, file), File.join(BASE_PATH, file + '.backup' ) )


db = SQLite3::Database.new( File.join(BASE_PATH, file) )

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
puts "Done."