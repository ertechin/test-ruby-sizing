class Donation < ApplicationRecord
  self.table_name = "donation" if ENV['RAILS_ENV'] != "development"
end
