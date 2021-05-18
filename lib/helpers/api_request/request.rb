# frozen_string_literal: true

module APIRequest
  # This class is responsible for sending http post requests for api testing
  #
  # ##### Usage:
  # Most common usecase is to build and send the request in one go:
  #   **<code>APIRequest::Request.build_and_submit(request_file, params)</code>**
  #   - __request_file__ is the filepath to the file conatining the request body
  #                    is searched under the __#{Environment::REQUESTS_DIR}__ directory
  #                    Example: request_file = 'consumer/create_consumer_request.xml'
  #   - __params__ is hash containing all tags to be merged/updated/replaced with the body from request_file
  #
  # The request can be build without sending with:
  #   **<code>request = APIRequest::Request.build(request_file, params)</code>**
  # which will return the request object of type APIRequest::Request
  # and can be sent with:
  #   __request.submit!__
  # returning the response body as html string
  #
  # If needed the response can be converted to hash with:
  #   __request.response_body__
  # or just the data unde the root tag:
  #   __request.response_body_root__
  class Request
    DELETE = 'delete'
    GET    = 'get'
    PATCH  = 'patch'
    POST   = 'post'
    PUT    = 'put'

    def self.build(request_body, env_config:, merge_params: {})
      @request = new(
                   { url:          env_config[:processing_url],
                     login:        env_config[:api_login],
                     password:     env_config[:api_password],
                     content_type: request_body.content_type,
                     request_url:  request_url(request_body.filename, env_config),
                     request_body: request_body.modify_request(merge_params) }
                 )

      Log.debug { "Request to: #{env_config[:processing_url]}\n#{@request.request_body}" }

      @request
    end

    def self.build_and_submit(request_body, env_config:, merge_params: {})
      build(request_body, env_config: env_config, merge_params: merge_params)
      @request.submit!
    end

    def initialize(request_params)
      @http_request                       = HTTPClient.new
      http_request.force_basic_auth       = true
      http_request.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @request_params                     = request_params
    end

    def self.request_url(filename, env_config)
      Log.debug { "Loading #{filename}\nenv_config: #{env_config}" }
      return env_config[:token] unless filename.include?('_request')

      filename.split('/').last.split('_request').first
    end

    def submit!
      url = generate_url_with_path(request_params[:url], request_params[:request_url])
      update_http_request_auth(url)

      @response = perform_request(
                    request_params[:http_method] || POST,
                    url,
                    generate_request_header_for(request_params[:token], request_params[:content_type]),
                    request_params[:request_body]
                  )

      self
    end

    def request_body
      request_params[:request_body]
    end

    def response_body
      Body.parse(@response, request_params[:content_type])
    end

    def response_body_root
      response_body.values.first
    end

    private

    attr_reader :http_request, :request_params

    def generate_url_with_path(url, path = nil)
      return url if path.blank?

      "#{url}/#{path}"
    end

    def perform_request(http_method, url, request_head, request_body)
      response = http_request.public_send(http_method, url, request_body, request_head, follow_redirect: true)
      Log.debug { "Response: #{response.body}" }

      response.body
    end

    def update_http_request_auth(url)
      login    = request_params[:login]
      password = request_params[:password]
      http_request.set_auth(url, login, password) if login.present? && password.present?
    end

    def generate_request_header_for(token, content_type)
      header_params = {}

      header_params['Authorization'] = "Token #{token}" if token.present?
      header_params['Content-Type']  = "application/#{content_type}"
      header_params['cache-control'] = 'no-cache'

      header_params
    end
  end
end
