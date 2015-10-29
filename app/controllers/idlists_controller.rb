class IdlistsController < ApplicationController
  def index
  end

  def id_check
    @t1 = Time.now
    @id = params[:id]

    @check = vaild_id?(@id)
    @country = convert_code_to_country(@id)

    render 'index'
  end

  private

  def vaild_id?(id)
    $check_number = 0
    $id_chars = id.chars
    $cal = [1,9,8,7,6,5,4,3,2,1,1]
    map = { 'A' => [1, 0], 'B' => [1, 1], 'C' => [1, 2], 'D' => [1, 3],
     'E' => [1, 4], 'F' => [1, 5], 'G' => [1, 6], 'H' => [1, 7], 'I' => [3, 4],
      'J' => [1, 8], 'K' => [1, 9], 'L' => [2, 0], 'M' => [2, 1], 'N' => [2, 2],
      'O' => [3, 5], 'P' => [2, 3], 'Q' => [2, 4], 'R' => [2, 5],
      'S' => [2, 6], 'T' => [2, 7], 'U' => [2, 8], 'V' => [2, 9], 'W' => [3, 2],
      'X' => [3, 0], 'Y' => [3, 1], 'Z' => [3, 3]}
    $i = 0
    numbers = map[$id_chars.shift]+$id_chars.map(&:to_i)

    while $i < 11 do
      $check_number += numbers[$i] * $cal[$i]
      $i += 1
    end

    $check_number % 10 == 0

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
end
