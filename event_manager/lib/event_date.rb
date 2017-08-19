require 'csv'

contents = CSV.open "event_attendees.csv", headers:true, header_converters: :symbol

hours = contents.map do |row|
  dt = DateTime.strptime(row[:regdate], '%m/%d/%Y %H:%M')
  dt.hour
end

hours_freq = hours.inject({}) do |memo, hour|
  memo[hour] ||= 0
  memo[hour] += 1
  memo
end
puts hours_freq

contents = CSV.open "event_attendees.csv", headers:true, header_converters: :symbol

days_freq = contents.inject({}) do |memo, row|
  wday = DateTime.strptime(row[:regdate], '%m/%d/%Y %H:%M').wday
  memo.tap { |h| h.store(wday, memo[wday] ? memo[wday] + 1 : 1 )}

end


puts days_freq
