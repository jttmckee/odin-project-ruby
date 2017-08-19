require "csv"
require 'sunlight/congress'
require 'erb'
Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"


def clean_zipcode(zipcode)
  zipcode.to_s.rjust( 5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
   Sunlight::Congress::Legislator.by_zipcode(zipcode)

end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end
  def clean_phone_number(phone)
    return "BAD" unless phone

    number = phone.to_s.gsub(/[\-\(\)\s\.]/,"")
    size = number.size
    if size < 10
      return "BAD"
    elsif size == 10
      return number
    elsif size == 11
      if number[0] == "1"
        return number[1..10]
      else
        return "BAD"
      end
    else
      return "BAD"
    end
  end


puts "EventManager Initialized"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = clean_phone_number(row[:homephone])
  puts phone + "   " + row[:homephone]

  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)

end
