namespace :heroku do
  desc "Pushes local DB to Heroku"
  task pg_push: :environment do
    puts "Dropping the production DB..."
    run 'heroku pg:reset --confirm opti-recruit'

    puts 'Pushing DB to Heroko...'
    run 'heroku pg:push opti_recruit_fe_development DATABASE_URL'
  end

  desc 'Drops development DB and replaces it with the production DB'
  task pg_pull: :environment do
    puts '-----> Setting the environment...'
    run 'RAILS_ENV=development rails db:environment:set'

    puts '-----> dropping DB…'
    run 'rails db:drop'

    puts '-----> pulling the DB...'
    run 'heroku pg:pull postgresql-concentric-68522 opti_recruit_fe_development'
  end

  def run(*cmd)
    system(*cmd)
    raise "Command #{cmd.inspect} failed!" unless $?.success?
  end
end
