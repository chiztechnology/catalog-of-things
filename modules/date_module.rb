module DateModule
  module_function

  def correct_date_format
    loop do
      print "\nPublish date[yyyy-mm-dd]: "
      date_string = gets.chomp

      begin
        Date.parse(date_string)
        return date_string
      rescue ArgumentError
        puts 'Date is not well-formatted, please insert the date again'
      end
    end
  end
end
