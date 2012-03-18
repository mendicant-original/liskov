require 'fileutils'
require 'securerandom'
require 'highline'

desc 'Setup project for development / deploy'
task :setup do

  console = HighLine.new

  section "Configuration Files" do

    database       = Rails.root.join('config', 'database.yml')
    secret_token   = Rails.root.join('config', 'initializers', 'secret_token.rb')
    omniauth       = Rails.root.join('config', 'initializers', 'omniauth.rb')
    clubhouse_dir  = Rails.root.join('test', 'fixtures', 'clubhouse', 'people')

    unless File.exists?(database)
      create_from_example(database, "Database config", true)
    else
      puts "Database config file already exists"
    end

    unless File.exists?(secret_token)
      secret   = SecureRandom.hex(64)
      template = ERB.new(File.read("#{secret_token}.example"))

      File.open(secret_token, 'w') {|f| f.write(template.result(binding)) }
      puts "Secret Token Generated"
    else
      puts "Secret Token file already exists"
    end

    unless File.exists?(omniauth)
      create_from_example(omniauth, "Omniauth config")
    else
      puts "Omniauth config file already exists"
    end

    if Dir.glob(clubhouse_dir.join('*.json')).empty?
      puts "" # Empty Line
      puts "It looks like you don't have a clubhouse fixture setup."
      puts "You'll need if you are running in development mode"

      if console.agree("Would you like to create one now?")
        github = console.ask("What github nickname would you like to use?") { |q| q.validate = /\S+/}

        create_file(clubhouse_dir.join('github_nickname.json.example'),
          clubhouse_dir.join("#{github}.json"), 'clubhouse', true)
      end
    end

  end

  section "Database" do
    begin
      # Check if there are pending migrations
      silence { Rake::Task["db:abort_if_pending_migrations"].invoke }
      puts "Skip: Database already setup"
    rescue Exception
      silence do
        Rake::Task["db:create"].invoke
        Rake::Task["db:schema:load"].invoke
      end
      puts "Database setup"
    end
  end

  # Load the Rails Env now that the databases are setup
  Rake::Task["environment"].invoke

  section "Seed Data" do
    Rake::Task["db:seed"].invoke
  end

  section "Add mendicant-university/liskov as upstream" do
    upstream_exists = `git remote | grep upstream`
    if upstream_exists.empty?
      sh %{ git remote add upstream git@github.com:mendicant-university/liskov.git } do |ok, res|
        puts "Unable to add main liskov repo as upstream: Status => #{res.exitstatus}" if !ok
      end
    end
  end

  puts # Empty Line
  puts "==== Setup Complete ====".color(:green)
  puts # Empty Line
end

private

def section(description)
  puts # Empty Line
  puts description.underline
  puts # Empty Line
  yield
end

def silence
  begin
    orig_stderr = $stderr.clone
    orig_stdout = $stdout.clone

    $stderr.reopen File.new('/dev/null', 'w')
    $stdout.reopen File.new('/dev/null', 'w')

    return_value = yield
  rescue Exception => e
    $stdout.reopen orig_stdout
    $stderr.reopen orig_stderr
    raise e
  ensure
    $stdout.reopen orig_stdout
    $stderr.reopen orig_stderr
  end

  return_value
end

def create_file(source, destination, name, requires_edit=false)
  FileUtils.cp(source, destination)
  puts "#{name} file created".color(:green)

  if requires_edit
    puts "Update #{destination} and run `bundle exec rake setup` to continue".color(:red)
    system(ENV['EDITOR'], destination.to_s) unless ENV['EDITOR'].blank?
    exit
  end
end

def create_from_example(file, name, requires_edit = false)
  create_file(file.to_s + '.example', file, name, requires_edit)
end
