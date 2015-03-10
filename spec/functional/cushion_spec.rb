require_relative "../../lib/cushion"
require 'json'
include Cushion

describe ENV, "environment variables" do
  it { should include("CUSHION_HOST", "CUSHION_DB") }
end

describe "Cushion::Api" do
  subject(:api) { Cushion::Api.new(ENV['CUSHION_URL'], ENV['CUSHION_DB'], 'password1') }

  it { should respond_to(:url)}
end
