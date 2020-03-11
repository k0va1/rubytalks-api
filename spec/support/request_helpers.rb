# frozen_string_literal: true

module RequestHelpers
  APP = Hanami.app

  class Request
    def initialize(method, path, options)
      @path, @query_string = path.split('?', 2)
      @method = method
      @body = options[:body]
      @headers = options[:headers] || {}
    end

    def env
      default_env.tap do |env|
        env['PATH_INFO'] = @path
        env['REQUEST_METHOD'] = @method
        env['QUERY_STRING'] = @query_string
        env['rack.input'] = StringIO.new(@body) if @body

        @headers.each do |key, value|
          rack_name = key.upcase.tr('-', '_')
          rack_name = "HTTP_#{rack_name}" unless rack_name == 'CONTENT_TYPE'
          env[rack_name] = value
        end
      end
    end

    def default_env
      {
        'SCRIPT_NAME' => '',
        'SERVER_NAME' => 'localhost',
        'SERVER_PORT' => '800613',
        'rack.version' => [1, 3],
        'rack.url_scheme' => 'http',
        'rack.input' => StringIO.new,
        'rack.errors' => StringIO.new,
        'rack.multithread' => false,
        'rack.multiprocess' => false,
        'rack.run_once' => false,
        'rack.hijack?' => false
      }
    end
  end

  def default_headers
    { 'Content-Type' => 'application/json' }
  end

  def do_request(verb, path, options)
    create_request(verb, path, options).then { |request| perform_request(request) }
  end

  def perform_request(request)
    @response = APP.call(request.env)
  end

  def create_request(verb, path, options)
    Request.new(verb, path, options)
  end

  def response
    @response
  end

  def response_status
    response[0]
  end

  def response_headers
    response[1]
  end

  def response_body
    response[2].instance_variable_get(:@body).first
  end

  def response_hash
    @response_hash ||= JSON.parse(response_body)
  end

  def response_data
    response_hash.fetch('data')
  end

  def get(path, options = {})
    do_request('GET', path, options)
  end

  def post(path, options = {})
    do_request('POST', path, options)
  end

  def patch(path, options = {})
    do_request('PATCH', path, options)
  end

  def put(path, options = {})
    do_request('PUT', path, options)
  end

  def options(path, options = {})
    do_request('OPTIONS', path, options)
  end

  def delete(path, options = {})
    do_request('DELETE', path, options)
  end
end
