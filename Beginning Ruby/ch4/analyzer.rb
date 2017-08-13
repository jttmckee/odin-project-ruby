
lines = File.readlines(ARGV[0])

line_count = lines.size

text = lines.join
total_characters = text.length
total_characters_nospaces = text.gsub(/\s+/,'').length
words = text.split
word_count = words.length
sentence_count = text.split(/\?|\.|!/).length
paragraph_count = text.split(/\n\n/).length

stopwords = %w{the a by on for of are with just but and to the my I has some in}

keywords = words.select {|word| !stopwords.include? (word) }.length.to_f
good_word_pct = ((keywords / word_count.to_f) * 100).to_i

#Summarise
sentences = text.gsub(/\s+/,' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

puts "#{line_count} lines"
puts "#{total_characters} characters"
puts "#{total_characters_nospaces} characters (excluding spaces)"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{word_count / sentence_count} words per sentence on average"
puts "#{sentence_count / paragraph_count} sentences per paragraph on average"
puts "#{good_word_pct}% of words are good words"
puts "A summary of the text is:"
puts ideal_sentences.join(". ")
