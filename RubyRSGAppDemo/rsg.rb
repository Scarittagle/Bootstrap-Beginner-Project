# Extracts just the definitions from the grammar file
# Returns an array of strings where each string is the lines for
# a given definition (without the braces)
def read_grammar_defs(filename)
  filename = 'grammars/' + filename unless filename.start_with? 'grammars/'
  filename += '.g' unless filename.end_with? '.g'
  contents = open(filename, 'r') { |f| f.read }
  contents.scan(/\{(.+?)\}/m).map do |rule_array|
    rule_array[0]
  end
end

# Takes data as returned by read_grammar_defs and reformats it
# in the form of an array with the first element being the
# non-terminal and the other elements being the productions for
# that non-terminal.
# Remember that a production can be empty (see third example)
# Example:
#   split_definition "\n<start>\nYou <adj> <name> . ;\nMay <curse> . ;\n"
#     returns ["<start>", "You <adj> <name> .", "May <curse> ."]
#   split_definition "\n<start>\nYou <adj> <name> . ;\n;\n"
#     returns ["<start>", "You <adj> <name> .", ""]
def split_definition(raw_def)
  # TODO: your implementation
  #Place the line into an array that creates an 2D array
  splitarr = raw_def.map{|x| [x]}
  #Split defs by keyword: \n
  splitarr = splitarr.map{|x| x.join.split /[\n]+/ }
  #replaces any extra semicolon to blank
  splitarr = splitarr.map{|x| x == ";" ? "" : x}
  #trim down any extra \t's ... and spaces on non-terminal
  splitarr = splitarr.map{|x| x.map{|y| y.tr("\t;", '')}}
  #remove the first blank that is left by split method.
  splitarr.map{|x| x[1..-1]}
end

# Takes an array of definitions where the definitions have been
# processed by split_definition and returns a Hash that
# is the grammar where the key values are the non-terminals
# for a rule and the values are arrays of arrays containing
# the productions (each production is a separate sub-array)

# Example:
# to_grammar_hash([["<start>", "The   <object>   <verb>   tonight."], ["<object>", "waves", "big    yellow       flowers", "slugs"], ["<verb>", "sigh <adverb>", "portend like <object>", "die <adverb>"], ["<adverb>", "warily", "grumpily"]])
# returns {"<start>"=>[["The", "<object>", "<verb>", "tonight."]], "<object>"=>[["waves"], ["big", "yellow", "flowers"], ["slugs"]], "<verb>"=>[["sigh", "<adverb>"], ["portend", "like", "<object>"], ["die", "<adverb>"]], "<adverb>"=>[["warily"], ["grumpily"]]}
def to_grammar_hash(split_def_array)
  # TODO: your implementation here
  #Further splits any leftover sentence with spaces
  arrHash = split_def_array.map{|x, *y| [x, y.map{|z| z.split(" ")}]}
  #convert it to hash
  arrHash = arrHash.to_h
  #Maybe for the Extra Credit:
  #Removing that ridiculous non-sense whitespace that still left in non-term.
  arrHash.map{ |k, v| [k.strip, v] }.to_h
end

# Returns true iff s is a non-terminal
# a.k.a. a string where the first character is <
#        and the last character is >
def is_non_terminal?(s)
  # TODO: your implementation here
  #Just....use include? method
  s.include?('<' && '>') ? true : false
end

# Given a grammar hash (as returned by to_grammar_hash)
# returns a string that is a randomly generated sentence from
# that grammar
#
# Once the grammar is loaded up, begin with the <start> production and expand it to generate a
# random sentence.
# Note that the algorithm to traverse the data structure and
# return the terminals is extremely recursive.
#
# The grammar will always contain a <start> non-terminal to begin the
# expansion. It will not necessarily be the first definition in the file,
# but it will always be defined eventually. Your code can
# assume that the grammar files are syntactically correct
# (i.e. have a start definition, have the correct  punctuation and format
# as described above, don't have some sort of endless recursive cycle in the
# expansion, etc.). The names of non-terminals should be considered
# case-insensitively, <NOUN> matches <Noun> and <noun>, for example.
def expand(grammar, non_term="<start>")
  # TODO: your implementation here
  #Use def within def technique
  #Because I need to use recursive way to generate it
  #Transfer the input grammar into instance Variable to it can access by the inner def
  @insVargrammar = grammar
  #Create a empty sentence to store the randomly assembled words
  @sentence = []
  #The inner recursive def
  def generate(key)
    #Randomly pick values by the key (Start with "<start>")
    words = @insVargrammar[key].sample
    words.each do |word|
      #Check the word if is non_terminal, if so it will do recursive step.
      if (is_non_terminal?(word))
        generate(word)
      else
        @sentence << word
      end
    end
  end
  #Start the generation here
  generate(non_term)
  #the words needed to link each other to be a sentence.
  @sentence.join(' ')
end

# Given the name of a grammar file,
# read the grammar file and print a
# random expansion of the grammar
def rsg(filename)
  # TODO: your implementation here
  defs = read_grammar_defs(filename)
  defs = split_definition(defs)
  defs = to_grammar_hash(defs)
  expand(defs)
end

if __FILE__ == $0
  # TODO: your implementation of the following
  # prompt the user for the name of a grammar file
  # rsg that file
  puts "Enter the name of the file: "
  fileName = gets.chomp
  puts "Generating..."
  rsg(fileName)
end
