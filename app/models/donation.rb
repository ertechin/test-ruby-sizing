class Donation < ApplicationRecord

  def self.last_donate_year
    Donation.limit(1).order(updated_at: :desc)
  end

  def self.biggest_five_donations
    Donation.limit(5).order(donate_count: :desc).reverse
  end

  def self.user_gyear_donations(params)
    Donation.where(gyear: params[:gyear])
  end

  def self.donate_count_percent
    all_donations = Donation.all
    donations_array = all_donations.as_json.map do |e|
      percent = (e['donate_count'] / e['class_count'].to_f) * 100
      e.merge!('donate_percent' => percent.truncate(2))
    end
    sorted_donations_array = donations_array.sort_by { |e| e['donate_percent'].to_f }
    sorted_donations_array.last(10)
  end

end
