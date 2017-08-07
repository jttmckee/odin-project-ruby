#Copied from: http://ruby.bastardsbook.com/chapters/exception-handling/ then amended
require 'open-uri'
require 'timeout'

remote_base_url = "https://en.wikipedia.org/wiki"

start_year = 1999
end_year = 2200

(start_year..end_year).each do |yr|
 begin
   rpage = open("#{remote_base_url}/#{yr}")
   puts "Year: #{yr} found!"
 rescue StandardError=>e
   puts "Error: #{e} for year: #{yr}"
 else
   rdata = rpage.read
 ensure
   puts "sleeping"
   sleep 2
 end

 if rdata
   File.open("copy-of-#{yr}.html", "w"){|f| f.write(rdata) }

 end
end
