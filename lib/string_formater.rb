class StringFormater

  attr_reader :input_string, :key

  ALPHABETS = ("a".."z").to_a
  NUMBERS = (0..9).to_a.map(&:to_s)

  def initialize(input_string = '', key='')
    @input_string = input_string
    @key = key
  end

  def compress
    input_string.split("").each_with_index.reduce('') do |acc, (char, index)|

      begin
        Integer(char)
        acc = acc        
      rescue ArgumentError
        if index == 0
          acc = "1#{char}" 
        else
          acc_length = acc.length
          last_char = acc[acc_length - 1]
          dup_acc = acc.dup # Since acc is frozen creating a dup

          if last_char == char
            dup_acc[acc_length - 2] = (dup_acc[acc_length - 2].to_i + 1).to_s
            acc = dup_acc
          else
            acc = "#{acc}1#{char}"
          end
        end
      end


      acc
    end
  end

  def decompress
    letter_pairs = input_string.scan(/../)
    letter_pairs.reduce('') do |acc, letter_pair|
      first_letter = letter_pair[0]
      begin
        number = Integer(first_letter)

        acc = acc + (0..number-1).reduce('') do |in_acc, number|
          in_acc = in_acc + letter_pair[1]
        end
      rescue ArgumentError 
        acc = acc
      end

      acc
    end
  end


  def encrypt
    input_string.split('').map(&:downcase).reduce('') do |acc, letter|
     
      if ALPHABETS.include?(letter)
        letter_index = ALPHABETS.index(letter)
        acc = acc + ALPHABETS[letter_index + key - 26]

      elsif NUMBERS.include?(letter)
        letter_index = NUMBERS.index(letter)
        acc = acc + NUMBERS[letter_index + key - 10] 

      else
        acc = acc + letter
      end

      acc
    end
  end

  def decrypt
    input_string.split('').map(&:downcase).reduce('') do |acc, letter|
      if ALPHABETS.include?(letter)
        letter_index = ALPHABETS.index(letter)
        pointer_index = letter_index - key

        if pointer_index.negative?
          acc = acc + ALPHABETS[pointer_index + 26]
        else
          acc = acc + ALPHABETS[pointer_index]
        end
      elsif NUMBERS.include?(letter)
        letter_index = NUMBERS.index(letter)
        pointer_index = letter_index - key

        if pointer_index.negative?
          acc = acc + NUMBERS[pointer_index + 10] 
        else
          acc = acc + NUMBERS[pointer_index]
        end

      else
        acc = acc + letter
      end

      acc
    end

  end

end