class Api::V1::DonationsController < ApiController

  def take_donations
    @last_donate_year = Donation.last_donate_year
    @biggest_five_donations = Donation.biggest_five_donations
    @user_gyear_donations = Donation.user_gyear_donations(params)
    @percent_of_donations = Donation.donate_count_percent
  end
  
end
