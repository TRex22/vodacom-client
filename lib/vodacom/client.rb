module Vodacom
  class Client
    LOGIN_PATH = 'https://www.vodacom.co.za/cloud/login/v3/login'
    BALANCE_PATH = 'https://www.vodacom.co.za/cloud/rest/balances/v3/bundle/balances/'

    attr_reader :username, :password, :base_path, :port

    def initialize(username:, password:, base_path: 'https://www.vodacom.co.za/cloud', port: 80)
      @username = username
      @password = password
      @base_path = base_path
      @port = port
    end

    def self.compatible_api_version
      'v3'
    end

    # This is the version of the API docs this client was built off-of
    def self.api_version
      'v3 2021-03-13'
    end

    private

    def login
      start_time = get_micro_second_time

      response = HTTParty.send(
        :post,
        LOGIN_PATH,
        body: payload,
        headers: {
          'Content-Type': 'application/json',
          'Authority': 'www.vodacom.co.za',
          'x-application-context': 'vod-ms-zuul-gateway-crd:prodcluster:8091',
          'Accept': '*/*'
        },
        port: port,
        format: :json
      )

      end_time = get_micro_second_time
      construct_response_object(response, path, start_time, end_time)
    end

    def authorise_and_send(http_method:, path:, payload: {}, params: {})
      auth = {username: username, password: password}

      start_time = get_micro_second_time

      response = HTTParty.send(
        http_method.to_sym,
        construct_base_path(path, params),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        basic_auth: auth,
        format: :json
      )

      end_time = get_micro_second_time
      construct_response_object(response, path, start_time, end_time)
    end

    def construct_response_object(response, path, start_time, end_time)
      {
        'body' => parse_body(response, path),
        'headers' => response.headers,
        'metadata' => construct_metadata(response, start_time, end_time)
      }
    end

    def construct_metadata(response, start_time, end_time)
      total_time = end_time - start_time

      {
        'start_time' => start_time,
        'end_time' => end_time,
        'total_time' => total_time
      }
    end

    def body_is_present?(response)
      !body_is_missing?(response)
    end

    def body_is_missing?(response)
      response.body.nil? || response.body.empty?
    end

    def parse_body(response, path)
      parsed_response = JSON.parse(response.body) # Purposely not using HTTParty

      if parsed_response.dig(path.to_s)
        parsed_response.dig(path.to_s)
      else
        parsed_response
      end
    rescue JSON::ParserError => _e
      response.body
    end

    def get_micro_second_time
      (Time.now.to_f * 1000000).to_i
    end

    def construct_base_path(path, params)
      constructed_path = "#{base_path}/#{path}"

      if params == {}
        constructed_path
      else
        "#{constructed_path}?#{process_params(params)}"
      end
    end

    def process_params(params)
      params.keys.map { |key| "#{key}=#{params[key]}" }.join('&')
    end
  end
end
