Model.find(:all, :conditions => (["name = ?", params[:term]]), :limit => 5)
scope :active, :conditions => {:active => true}, :order => 'created_at'
has_many :articles, :class_name => "Post", :order => 'updated_at DESC'
