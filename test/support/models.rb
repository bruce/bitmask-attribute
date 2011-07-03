ActiveRecord::Schema.define do 
  create_table :campaigns do |t|
    t.integer :company_id
    t.integer :medium, :misc, :Legacy
  end
  create_table :companies do |t|
    t.string :name
  end
end


class Company < ActiveRecord::Base
  has_many :campaigns
end

# Pseudo model for testing purposes
class Campaign < ActiveRecord::Base
  belongs_to :company
  bitmask :medium, :as => [:web, :print, :email, :phone]
  bitmask :misc, :as => %w(some useless values) do
    def worked?
      true
    end
  end
  bitmask :Legacy, :as => [:upper, :case]
end