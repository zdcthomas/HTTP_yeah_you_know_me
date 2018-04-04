module WordSearch
  def word_search(word)
    word = word.downcase
    dictionary = File.read('/usr/share/dict/words').split
    if dictionary.include?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end
end
