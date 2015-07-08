require 'cgi'
require 'uri'
require 'net/http'
require 'net/https'
require 'nokogiri'

class BingTranslator
  ACCESS_TOKEN_URI = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
  HTTP_URI = "http://api.microsofttranslator.com/v2/Http.svc/Translate"
  SCOPE_URI = 'http://api.microsofttranslator.com'

  class AuthenticationException < StandardError; end

  def initialize(client_id, client_secret, skip_ssl_verify = false, account_key = nil)
    @client_id = client_id
    @client_secret = client_secret
    @account_key = account_key
    @skip_ssl_verify = skip_ssl_verify

    @translate_uri = URI.parse HTTP_URI
    @access_token_uri = URI.parse ACCESS_TOKEN_URI
  end

  def translate(from_lang, to_lang, text)
    access_token = get_access_token

    params = {
        'to' => CGI.escape(to_lang.to_s),
        'text' => CGI.escape(text),
        'category' => 'general',
        'contentType' => 'text/plain',
        'from' => from_lang.to_s
    }

    uri = @translate_uri
    result = Net::HTTP.new(uri.host, uri.port).get(
        "#{uri.path}?#{prepare_param_string(params)}",
        { 'Authorization' => "Bearer #{access_token['access_token']}" })

    Nokogiri.parse(result.body).xpath("//xmlns:string")[0].content
  end

  def get_access_token
    return @access_token if @access_token and
        Time.now < @access_token['expires_at']

    params = {
        'client_id' => CGI.escape(@client_id),
        'client_secret' => CGI.escape(@client_secret),
        'scope' => CGI.escape(SCOPE_URI),
        'grant_type' => 'client_credentials'
    }

    http = Net::HTTP.new(@access_token_uri.host, @access_token_uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if @skip_ssl_verify

    response = http.post(@access_token_uri.path, prepare_param_string(params))

    @access_token = JSON.parse(response.body)
    raise AuthenticationException, @access_token['error'] if @access_token["error"]
    @access_token['expires_at'] = Time.now + @access_token['expires_in'].to_i
    @access_token
  end

  private

  def prepare_param_string(params)
    params.map { |key, value| "#{key}=#{value}" }.join '&'
  end
end