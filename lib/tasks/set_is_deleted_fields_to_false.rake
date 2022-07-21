namespace :init do
    desc "Set the is_deleted fields to false in User table"
    task :update_is_deleted_fields => [:environment] do
        User.update_all(is_deleted: false)
    end
  end