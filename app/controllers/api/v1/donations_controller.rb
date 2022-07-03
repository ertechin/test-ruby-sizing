class Api::V1::DonationsController < ApiController

  def take_donations
    @last_donate_year = Donation.last_donate_year
    @biggest_five_donations = Donation.biggest_five_donations
    @user_gyear_donations = Donation.user_gyear_donations(params)
  end
  
end
