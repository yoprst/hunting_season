require 'spec_helper'

describe "Users API" do

  before(:all) do
    @client = ProductHunt::Client.new(ENV['TOKEN'] || 'my-token')
  end

  it 'implements users#show and yields the details of a specific user' do
    stub_request(:get, "https://api.producthunt.com/v1/users/rrhoover").
      to_return(File.new("./spec/support/webmocks/get_user.txt"))

    user = @client.user('rrhoover')

    expect(user['name']).to eq('Ryan Hoover')
    expect(user['id']).to eq(2)
  end

  it 'implements users#index' do
    stub_request(:get, "https://api.producthunt.com/v1/users?order=asc").
      to_return(File.new("./spec/support/webmocks/get_users.txt"))

    user = @client.users(order: 'asc').first

    expect(user['name']).to eq('Nathan Bashaw')
    expect(user['id']).to eq(1)
  end

  it 'implements #current_user and yields the details of currently authenticated user' do
    stub_request(:get, "https://api.producthunt.com/v1/me").
      to_return(File.new("./spec/support/me.txt"))

    user = @client.current_user

    expect(user['name']).to eq('Mike Jarema')
    expect(user['id']).to eq(13071)
  end

end
