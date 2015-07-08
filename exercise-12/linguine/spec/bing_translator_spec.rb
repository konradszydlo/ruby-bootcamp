require File.dirname(__FILE__) + '/../bing_translator'

describe BingTranslator do

  subject do
    described_class.new 'client_id', 'client_secret'
  end

  before :each do

    body = %Q{{"token_type":"http://schemas.xmlsoap.org/ws/2009/11/swt-token-profile-1.0","access_token":"http%3a%2f%2fschemas.xmlsoap.org%2fws%2f2005%2f05%2fidentity%2fclaims%2fnameidentifier=ruby_bootcamp_exercise_12_linguine&http%3a%2f%2fschemas.microsoft.com%2faccesscontrolservice%2f2010%2f07%2fclaims%2fidentityprovider=https%3a%2f%2fdatamarket.accesscontrol.windows.net%2f&Audience=http%3a%2f%2fapi.microsofttranslator.com&ExpiresOn=1436267545&Issuer=https%3a%2f%2fdatamarket.accesscontrol.windows.net%2f&HMACSHA256=kr2bFZyly3pDLKiyFvuO1C%2bRcof2vahbgAJLwKYN20Q%3d","expires_in":"600","scope":"http://api.microsofttranslator.com"}}

    stub_request(:post, "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13").
        with(:body => "client_id=client_id&client_secret=client_secret&scope=http%3A%2F%2Fapi.microsofttranslator.com&grant_type=client_credentials",
             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => body, :headers => {})

  end

  describe '#get_access_token' do
    it 'returns token that is a hash' do
      expect(subject.get_access_token).to be_an_instance_of(Hash)
    end
    it 'returns token with expiration' do
      expect(subject.get_access_token['expires_in']).to eq('600')
    end

  end
end
