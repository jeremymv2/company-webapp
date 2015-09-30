require 'serverspec'

set :backend, :exec

describe 'application page' do
  before do
    ENV.delete('http_proxy')
  end

  it 'serves back an our desired content' do
    expect((command 'wget -q -O - http://localhost:8000').stdout).to match(/PSE Exercise/)
  end
end