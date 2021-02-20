module VinsManager
  FORBIDDEN_CHARS = 'IOQ'

  def fetch_vin_information(vin)
    check_forbidden_chars(vin)
  end

  def check_forbidden_chars(vin)
    if vin.match?(/[#{FORBIDDEN_CHARS}]/)
      error = []
      FORBIDDEN_CHARS.each_char { |c|
        error << "Incorrect character '#{c}' at position #{(vin =~ /#{c}/)+1}" if vin =~ /#{c}/
      }
      fill_vin_information(vin, nil, false,
                           'Contains invalid characters (I, O or Q)', error, [])
    else
      calculate_check_digit(vin)
    end
  end

  def transliterate(char)
    "0123456789.ABCDEFGH..JKLMN.P.R..STUVWXYZ".split('').index(char) % 10
  end

  def calculate_check_digit(vin)
    map = [0,1,2,3,4,5,6,7,8,9,'X']
    weights = [8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2]
    sum = 0
    vin.split('').each_with_index do |char, i|
      sum += transliterate(char) * weights[i]
    end
    check_digit_validity(vin, map[sum % 11])
  end

  def check_digit_validity(vin, checked_digit)
    if digits_match?(vin[8], checked_digit)
      fill_vin_information(vin, checked_digit, true, "This looks like a VALID VIN!", [], [])
    else
      suggested_vins = []
      suggested_vins << "#{vin[0..7]}#{checked_digit}#{vin[9..16]}"
      fill_vin_information(vin, vin[8], false,
                           "This looks like an INVALID VIN!",
                           ["Check digit #{vin[8]} is incorrect.
                             Correct value is #{checked_digit}."
                           ], suggested_vins
      )
    end
  end

  def digits_match?(char, digit)
    char == digit.to_s
  end

  def fill_vin_information(vin, check_digit, check_digit_valid, message, error, suggested_vins)
    @vins = { provided_vin: vin,
              check_digit: check_digit,
              check_digit_valid: check_digit_valid,
              message: message,
              error: error,
              suggested_vins: suggested_vins
    }
  end
end
