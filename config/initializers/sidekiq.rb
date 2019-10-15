def load_sidekiq_cron_jobs
  schedule_file = 'config/schedule.yml'

  if File.exists?(schedule_file)
    begin
      loaded_conf = YAML.load_file(schedule_file)
      Sidekiq::Cron::Job.load_from_hash(loaded_conf[Rails.env])
    rescue
      raise "Error loading Sidekiq configuration. Make sure the file #{schedule_file} exist and is configured for the #{Rails.env} environment"
    end
  end
end


Sidekiq.configure_server do |config|
  config.redis = { url: Rails.configuration.redis_database }

  load_sidekiq_cron_jobs
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.configuration.redis_database }
end
