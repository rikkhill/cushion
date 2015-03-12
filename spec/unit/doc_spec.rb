require_relative "../../lib/cushion"
require 'json'
require 'securerandom'
require 'pp'
include Cushion

describe Cushion::Doc, :unit do
  it "initialises with sensible defaults" do
    subject { Cushion::Doc.new() }

    subject { should have_id }
    expect(subject.id).to match(/[a-f0-9]{32}/)

    subject { should have_rev }
    expect(subject.rev).to eq 0

    subject { should have_keys }
    expect(subject.keys).to eq []
  end
end
