# コンピューターが実行する順番に数字をつけています。
# 書き方は人によって異なるので、別のメンターと見え方は違う可能性はありますが
# やってることは同じなので問題ありません。
# コードの中にコメントを書いて解説して行きます。


# -----------
# 4_月毎の日数
# -----------
def get_days(year, month)

  month_days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  if month == 2
    if year % 4 == 0
      if (year % 100 == 0) && (year % 400 != 0)
        days = 28
        #インテンド揃える
      else
        days = 29
      end
    else
      days = 28
    end
  else
    days = month_days[month]
  end

end

# -----------
# 3_年単位の日数の取得
# -----------
def get_years_of_days(year_count)
  #変数名がわかりにくいので書き直します。
    if year_count % 4 == 0

      if (year_count % 100 == 0) && (year_count % 400 != 0)
        year_days = 365
      else
        year_days = 366
      end

    else
      year_days = 365
    end

    return year_days
end

# -----------
# 2_その年までの合計日数
# -----------
def get_yearsnum(year_input)
  # year1 = year - 1
  # years = 0
  #
  # while year1 > 0 do
  #     years = years + get_years(year1)
  #     year1 = year1 - 1
  # end
  # return years

  year_for_count = year_input - 1
  days_sum_by_years = 0

  while year_for_count > 0 do
      days_sum_by_years = days_sum_by_years + get_years_of_days(year_for_count)
      year_for_count = year_for_count - 1
  end

  return days_sum_by_years
end


# -----------
# 1_曜日判定
# -----------
def get_week(year_input, month_input, day_input)
  #変数名がわかりにくいので書き直します。

  #week_days配列の定義
  week_days = ["日", "月", "火", "水", "木", "金", "土"]

  #month1 = month - 1
  #変数名がわかりにくいので書き直します。
  month_for_count = month_input - 1

  #days = 0

  #init
  days_total = 0

  # while month1 > 0 do
  #   days = days + get_yearsnum(year) + get_days(year, month1)
  #   month1 = month1 - 1
  # end

  #条件に1月の場合、つまりmonth_for_count==0
  #の場合でも適応されるように>=0としました。
  #確かに１年１月の場合は下の記述を読む必要はありませんが
  #２年目はget_yearsnum,get_daysは読む必要があります。
  while month_for_count >= 0 do
    #長いので改行しました。
    days_total = days_total \
                  + get_yearsnum(year_input) \
                  + get_days(year_input, month_for_count)

    month_for_count -= 1

  end

  days_total = days_total + day_input
  #week = week_days[(days+day)%7]
  week = week_days[days_total%7]

  #明示的に書いて置きます。
  return week
end


# -----------
# 0_実行部分
# -----------

puts "年を入力してください："
year = gets.to_i
puts "月を入力してください："
month = gets.to_i
puts "日を入力してください："
day = gets.to_i

week = get_week(year, month, day)
puts "#{year}年#{month}月#{day}日は#{week}曜日です"
