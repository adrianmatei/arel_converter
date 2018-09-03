require 'arel_converter'

begin
  finder = %Q{Model :all, :select => "DISTINCT(sales_channels.name)"}

  result = ArelConverter::Translator::Finder.translate(finder)
  puts finder
  puts result
rescue Exception => exception
  puts "Something went wrong: #{exception}"
end
