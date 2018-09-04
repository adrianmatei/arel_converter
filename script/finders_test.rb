require 'arel_converter'

begin
  # finder = %Q{self.find :all, :select => "DISTINCT(sales_channels.name)"}
  # finder = %Q{User.find :first, :joins => 'inner join class_teachers on users.id = teacher_id', :conditions => ['class_id = ? and users.id = ?', id, user_id]}
  finder = %Q{CategoryItem.find  :first, :conditions => ['catalog_category_id = ? and id = ?', catalog_category.id, params[:category_item_id]]}

  result = ArelConverter::Translator::Finder.translate(finder)
  puts finder
  puts result
rescue Exception => exception
  puts "Something went wrong: #{exception}"
end
