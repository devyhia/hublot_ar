# encoding: utf-8
module HublotAr

  # Clock argument for testing; defaults to Time
  def pretty(clock=Time.now)
    @expired = (clock-self).to_i
    @today = clock.strftime('%A')
    @created = self.to_time.strftime('%A')

    @days = {
      "Monday" => 1,
      "Tuesday" => 2,
      "Wednesday" => 3,
      "Thursday" => 4,
      "Friday" => 5,
      "Saturday" => 6,
      "Sunday" => 7
    }

    @days_ar = {
      "Monday" => "الإثنين",
      "Tuesday" => "الثلاثاء",
      "Wednesday" => "الأربعاء",
      "Thursday" => "الخميس",
      "Friday" => "الجمعة",
      "Saturday" => "السبت",
      "Sunday" => "الأحد"
    }

    return just_now     if just_now?
    return a_second_ago if a_second_ago?
    return seconds_ago  if seconds_ago?
    return a_minute_ago if a_minute_ago?
    return minutes_ago  if minutes_ago?
    return an_hour_ago  if an_hour_ago?
    return today        if is_today?
    return yesterday    if is_yesterday?
    return this_week    if this_week?
    return last_week    if last_week?
    return datetimefiesta
  end

private
  def just_now
    "الآن"
  end

  def just_now?
    @expired == 0
  end

  def a_second_ago
    "منذ ثانية"
  end

  def a_second_ago?
    @expired == 1
  end

  def seconds_ago
    "منذ #{ar_num @expired} ثواني"
  end

  def seconds_ago?
    @expired >= 2 && @expired <= 59
  end

  def a_minute_ago
    "منذ دقيقة"
  end

  def a_minute_ago?
    @expired >= 60 && @expired <= 119 #120 = 2 minutes
  end

  def minutes_ago
    "منذ #{ar_num (@expired/60)} دقائق"
  end

  def minutes_ago?
    @expired >= 120 && @expired <= 3599
  end

  def an_hour_ago
    "منذ ساعة"
  end

  def an_hour_ago?
    @expired >= 3600 && @expired <= 7199 # 3600 = 1 hour
  end

  def today
    "اليوم، الساعة " + localize_time(timeify)
  end

  def timeify
    "#{self.to_time.strftime("%l:%M %p")}"
  end

  def is_today?
    @days[@today] - @days[@created] == 0 && @expired >= 7200 && @expired <= 82800
  end

  def yesterday
    "الأمس، الساعة " + localize_time(timeify)
  end

  def is_yesterday?
    (@days[@today] - @days[@created] == 1 || @days[@created] + @days[@today] == 8) && @expired <= 172800
  end

  def this_week
    localize_day(@created) + "، الساعة " + localize_time(timeify)
  end

  def this_week?
    @expired <= 604800 && @days[@today] - @days[@created] != 0
  end

  def last_week
    localize_day(@created) + "الماضي، الساعة " + localize_time(timeify)
  end

  def last_week?
    @expired >= 518400 && @expired <= 1123200
  end

  def datetimefiesta
    self.strftime("%A, %B %e at %l:%M %p")
  end

  def localize_time(timeify)
    clock = timeify.split(' ').first.split(':').map{|e| ar_num(e.to_i)}.join(':')
    time = timeify.split(' ').last == 'AM' ? "ص" : "م"
    " #{clock} #{time}"
  end

  def localize_day(day)
    @days_ar[day]
  end

  def ar_num(nums)
    nums.to_s
    .gsub('0', '٠')
    .gsub('1', '١')
    .gsub('2', '٢')
    .gsub('3', '٣')
    .gsub('4', '٤')
    .gsub('5', '٥')
    .gsub('6', '٦')
    .gsub('7', '٧')
    .gsub('8', '٨')
    .gsub('9', '٩')
  end
end
