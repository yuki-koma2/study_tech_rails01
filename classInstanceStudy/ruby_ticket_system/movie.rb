class Movie
    def initialize(title, fee, start_date, end_date)
    @title = title
    @fee = fee
    @start_date = start_date
    @end_date = end_date
  end

  def title
    return @title
  end

  def fee
    return @fee
  end
end
