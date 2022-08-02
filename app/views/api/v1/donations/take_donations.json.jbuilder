json.donations_data do
    json.biggest_five_donations @biggest_five_donations
    json.last_donate_year @last_donate_year
    json.user_gyear_donations @user_gyear_donations
    json.percent_of_donations @percent_of_donations
end