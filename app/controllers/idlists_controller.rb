class IdlistsController < ApplicationController
  def index
  end

  def id_check
    @id = params[:q]

    @check = vaild_id?(@id)
    @country = convert_code_to_country(@id)
    @gender = gender?(@id)
    @check_digit = get_check_digit(calcute_amount_of_nine_digits(@id))

    render 'show'
  end

  def id_generate
    first_digit = ('A'..'Z').to_a.sample
    second_digit = ('1'..'2').to_a.sample
    other_digits = ""
    (3..9).each do |i|
      other_digits += ('0'..'9').to_a.sample
    end

    @id = ""
    temp_digits = first_digit + second_digit + other_digits
    numbers = calcute_amount_of_nine_digits(temp_digits)
    @id += temp_digits + get_check_digit(numbers).to_s

    @check = vaild_id?(@id)
    @gender = gender?(@id)
    @country = convert_code_to_country(@id)
    @check_digit = get_check_digit(numbers)

    render 'show'
  end

  private

  def vaild_id?(id)
    numbers = calcute_amount_of_nine_digits(id)

    id[9] == get_check_digit(numbers)
  end

  def convert_code_to_country(id)
    map = { 'A' => "台北市", 'B' => "台中市", 'C' => "基隆市", 'D' => "台南市",
     'E' => "高雄市", 'F' => "新北市", 'G' => "宜蘭縣", 'H' => "桃園市", 'I' => "嘉義市",
      'J' => "嘉義市", 'K' => "苗栗縣", 'L' => "台中縣", 'M' => "南投縣", 'N' => "彰化縣",
      'O' => "新竹市", 'P' => "雲林縣", 'Q' => "嘉義縣", 'R' => "台南縣",
      'S' => "高雄縣", 'T' => "屏東縣", 'U' => "花蓮縣", 'V' => "台東縣", 'W' => "金門縣",
      'X' => "澎湖縣", 'Y' => "陽明山管理局", 'Z' => "連江縣"}

    return map[id[0]]
  end

  def gender?(id)
    case id[1]
    when "1"
      "男性"
    when "2"
      "女性"
    end
  end

  def calcute_amount_of_nine_digits(id)
    check_number = 0
    id_chars = id.chars
    cal = [1,9,8,7,6,5,4,3,2,1,1]
    map = { 'A' => [1, 0], 'B' => [1, 1], 'C' => [1, 2], 'D' => [1, 3],
     'E' => [1, 4], 'F' => [1, 5], 'G' => [1, 6], 'H' => [1, 7], 'I' => [3, 4],
      'J' => [1, 8], 'K' => [1, 9], 'L' => [2, 0], 'M' => [2, 1], 'N' => [2, 2],
      'O' => [3, 5], 'P' => [2, 3], 'Q' => [2, 4], 'R' => [2, 5],
      'S' => [2, 6], 'T' => [2, 7], 'U' => [2, 8], 'V' => [2, 9], 'W' => [3, 2],
      'X' => [3, 0], 'Y' => [3, 1], 'Z' => [3, 3]}
    i = 0
    numbers = map[id_chars.shift]+id_chars.map(&:to_i)

    while i < 10 do
      check_number += numbers[i] * cal[i]
      i += 1
    end

    return check_number
  end

  def get_check_digit(number)
    return (10 - (number % 10)).to_s.last
  end

end
