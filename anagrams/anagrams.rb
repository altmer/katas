def tally(word)
  acc = {}
  index = 0
  while index < word.length
    ch = word[index]
    acc[ch] ||= 0
    acc[ch] += 1
    index += 1
  end
  acc
end

def word_hash(word)
  t = tally(word)
  res = ''
  t.keys.sort.each do |ch|
    res += "#{ch}#{t[ch]}"
  end
  res
end

def anagrams(words)
  acc = {}
  words.each do |word|
    key = word_hash(word)
    acc[key] ||= []
    acc[key] << word
  end
  acc.keys.map do |key|
    next if acc[key].length == 1
    acc[key].sort
  end.compact
end
