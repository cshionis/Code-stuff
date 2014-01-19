class Bob

  def hey(value)
    if !value.empty?
      if value == value.upcase && value =~ /[a-zA-Z]/
        return "Woah, chill out!"
      end
      if value.end_with?('?')
        return "Sure."
      end
      if value.split(" ").size == 0 || value == ''
          return "Fine. Be that way!"
      end
      return "Whatever."
    else
      return "Fine. Be that way!"
    end
  end

end

# class Bob

#   def hey(value)
#     case value
#     when is_shouting?(value)
#       'Woah, chill out!'
#     when question?(value)
#       'Sure.'
#     when no_chars?(value)
#       'Fine. Be that way!'
#     else
#       'Whatever.'
#     end
#   end

# end


# def is_shouting?(value)
#   return unless value.match(/[a-zA-Z]+/)
#   value == value.upcase
# end

# def question?(value)
#   value.end_with?('?') #value =~ /\?\z/ , value[-1,1] == '?'
# end

# def no_chars?(value)
#   value.strip.empty?
# end






