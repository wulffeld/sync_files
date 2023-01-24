namespace :sync_files do
  desc "Synchronize files"
  task :all => :environment do |t|
    SyncFiles::Sync.new.run
  end
end
