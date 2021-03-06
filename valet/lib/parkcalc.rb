class ParkCalcPage
  attr :page

  @@starting_prefix = 'Starting'
  @@leaving_prefix = 'Leaving'

  def initialize(page_handle)
    @page = page_handle
    @page.goto 'http://www.shino.de/parkcalc'
  end

  def thirty_minutes
    @page.text_field(:id, 'StartingDate').set '4/1/2014'
    @page.text_field(:id, 'LeavingDate').set '4/1/2014'
    @page.text_field(:id, 'LeavingTime').set '12:30'
  end

  def select_parking_lot(lot)
    @page.select_list(:id, 'ParkingLot').select lot
  end

  def fake_enter_parking_duration(duration)
    start_date, start_time, start_time_ampm, leave_date, leave_time, leave_time_ampm = @@duration_map[duration]
    set_date_time(@@starting_prefix, start_date, start_time, start_time_ampm)
    set_date_time(@@leaving_prefix, leave_date, leave_time, leave_time_ampm)
  end

  def enter_parking_duration(duration)
    startingDate, startingTime, startingTimeAMPM, leavingDate, leavingTime, leavingTimeAMPM = @@duration_map[duration]
    set_date_time(@@starting_prefix, startingDate, startingTime, startingTimeAMPM)
    set_date_time(@@leaving_prefix, leavingDate, leavingTime, leavingTimeAMPM)
  end

  def set_date_time(prefix, date, time, ampm)
   @page.text_field(:id, "#{prefix+"Date"}").set(date)
   @page.text_field(:id, "#{prefix+"Time"}").set(time)
   @page.radio(:name => "#{prefix+"TimeAMPM"}", :value=> ampm).set
  end

  def calculate_price
    @page.button(:value, 'Calculate').click
    @page.table[3][1].text.split[1].strip
  end

  @@duration_map = {
    '30 minutes'        => %w(05/04/2010 12:00 AM 05/04/2010 12:30 AM),
    '1 hour'            => %w(05/04/2010 12:00 AM 05/04/2010 01:00 AM),
    '1 hour 30 minutes' => %w(05/04/2010 12:00 AM 05/04/2010 01:30 AM),
    '2 hours'           => %w(05/04/2010 12:00 AM 05/04/2010 02:00 AM),
    '3 hours'           => %w(05/04/2010 12:00 AM 05/04/2010 03:00 AM),
    '3 hours 30 minutes' => %w(05/04/2010 12:00 AM 05/04/2010 03:30 AM),
    '5 hours'           => %w(05/04/2010 12:00 AM 05/04/2010 05:00 AM),
    '5 hours 1 minute'  => %w(05/04/2010 12:00 AM 05/04/2010 05:01 AM),
    '12 hours'          => %w(05/04/2010 12:00 AM 05/04/2010 12:00 PM),
    '12 hours 30 minutes' => %w(05/04/2010 12:00 AM 05/04/2010 12:30 PM),
    '24 hours'          => %w(05/04/2010 12:00 AM 05/05/2010 12:00 AM),
    '1 day 1 minute'    => %w(05/04/2010 12:00 AM 05/05/2010 12:01 AM),
    '1 day 30 minutes'  => %w(05/04/2010 12:00 AM 05/05/2010 12:30 AM),
    '1 day 1 hour'      => %w(05/04/2010 12:00 AM 05/05/2010 01:00 AM),
    '3 days'            => %w(05/04/2010 12:00 AM 05/07/2010 12:00 AM),
    '1 week'            => %w(05/04/2010 12:00 AM 05/11/2010 12:00 AM)
     }
end
