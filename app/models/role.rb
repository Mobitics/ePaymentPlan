class Role < ActiveRecord::Base
  ROLE_NAMES = { :admin => 'admin', :store => 'store' }
  
  validates_presence_of   :title
  validates_inclusion_of  :title, :in => ROLE_NAMES.values, :message => "'{{value}}' is not a valid role name"

  class << self
  	ROLE_NAMES.each do |key, value|
  	  class_eval do
    	  define_method(key) do
    	    find_by_title(value)
        end
	    end
    end
  end
  
  has_and_belongs_to_many :users
end
