# Controller for Donations fields
class Api::V1::DonationsController < ApiController
  def take_donations
    gyear = JSON.parse(params[:gyear])
    last_donate_year = Donation.limit(1).order(updated_at: :desc)
    biggest_five_donations = Donation.limit(5).order(donate_count: :desc)
    user_gyear_donations = Donation.where(gyear:)
    render json: {
      biggest_five_donations:,
      last_donate_year:,
      user_gyear_donations:,
      request_id: request.request_id
    }
  end
end
