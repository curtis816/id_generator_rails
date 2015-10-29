class IdlistsController < ApplicationController
  def index

  end

  def id_check
    @id = params[:id]

    @check = vaild_id?(@id)

    render 'index'
  end

  private

  def vaild_id?(id)
    $temp = 0
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
      $temp += numbers[$i] * $cal[$i]
      $i += 1
    end
    $check_number = $temp
    if $check_number % 10 == 0
      return true
    else
      return false
    end
  end
end
