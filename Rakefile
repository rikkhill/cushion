require 'rake'

begin
  require 'rspec/core/rake_task'
  desc "Functional tests"
  RSpec::Core::RakeTask.new(:func) do |t|
    t.rspec_opts = "--tag functional"
  end
  desc "Unit tests"
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = "--tag unit"
  end
rescue
end
