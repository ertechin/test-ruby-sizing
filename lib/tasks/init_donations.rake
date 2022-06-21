namespace :init do
  desc "Create Donation data between 1940 to 2030 year"
  task :donations => [:environment] do
    for year in 1940..2030
      Donation.create(gyear: year)
    end
  end
end
