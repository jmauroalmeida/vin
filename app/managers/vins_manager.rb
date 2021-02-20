module VinsManager

  FORBIDDEN_CHARS = 'IOQ'

  def check_vin(vin)
    sanitize_code(vin)
  end

  def sanitize_code(vin)
    if vin.match?(/[IOQ]/)
      @vin = { provided_vin: vin,
               check_digit: 'invalid',
               message: 'Contain invalid characters (I, O or Q)'
      }
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
    map[sum % 11]
  end
end
