require_relative "../../lib/cushion"
require 'json'
require 'pp'
require 'securerandom'
include Cushion

describe ENV, "environment variables", :functional do
  it { should include("CUSHION_HOST", "CUSHION_DB") }
end

describe "Cushion::Api", :functional do

  before { @uuid = SecureRandom.uuid.gsub(/-/, "") }

  subject(:api) { Cushion::Api.new(ENV['CUSHION_HOST'], ENV['CUSHION_DB'], 'password1') }

  it "has a couchdb server to talk to" do
    result = api.tap_host['couchdb']
    expect(result).to eq "Welcome"
  end

  it "has a database to read from" do
    result = api.tap_db['db_name']
    expect(result).to eq api.db
  end

  it "retrieves uuids" do
    uuid = api.get_uuid
    expect(/^[0-9a-f]{32}$/.match(uuid)).to be_truthy,
      "expected UUID, got #{uuid}"
  end

  it "puts, posts, gets and deletes documents on the database" do
    doc = {
      "fee"  => "eeny",
      "fi"   => "meeny",
      "fo"   => "miny",
      "fum"  => "mo"
    }

    # put something
    put = api.put_document(@uuid, doc)
    expect(put['ok']).to be_truthy

    # get it back
    get = api.get_document(@uuid)
    expect(get).to match a_hash_including doc

    # put something over the top of it
    rev_1 = get['_rev']
    new_doc = {
      "fee"  => "eeny",
      "fi"   => "meeny",
      "fo"   => "miny",
      "fum"  => "methuselah"
    }

    put_new = api.put_document(@uuid, new_doc.merge("_rev"=>rev_1))
    expect(put_new['ok']).to be_truthy

    # get it back again
    get_new = api.get_document(@uuid)
    expect(get_new).to match a_hash_including new_doc

    # delete it
    rev_2 = get_new['_rev']
    delete = api.delete_document(@uuid, rev_2)
    expect(delete['ok']).to be_truthy

    # post something
    post = api.post_document(doc)
    expect(post['ok']).to be_truthy

  end
end
