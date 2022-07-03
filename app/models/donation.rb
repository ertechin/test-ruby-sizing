class Donation < ApplicationRecord

  def self.last_donate_year
    @last_donate_year = Donation.limit(1).order(updated_at: :desc)
  end

  def self.biggest_five_donations
    @biggest_five_donations = Donation.limit(5).order(donate_count: :desc)
  end

  def self.user_gyear_donations(params)
    @user_gyear_donations = Donation.where(gyear: params[:gyear])
  end

end
