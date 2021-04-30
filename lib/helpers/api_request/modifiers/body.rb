# frozen_string_literal: true

module APIRequest
  # Base data modifier
  class Body
    attr_reader :body, :content_type, :filename

    def self.load_from_file(filename)
      APIRequest.const_get(content_type_from_filename(filename).capitalize)
        .new("#{Environment::REQUESTS_DIR}/#{filename}")
    end

    def self.parse(content, content_type)
      APIRequest.const_get(content_type.capitalize).parse(content)
    end

    def self.content_type_from_filename(filename)
      filename.split('.').last
    end

    def initialize(filename)
      raise 'APIRequest::Body Class cannot be initialized. Use Body.load_from_file' if instance_of?(Body)

      @filename     = filename
      @content_type = self.class.content_type_from_filename(filename)
      parse_body
    end

    def modify_request(params = {})
      merge_request(params)
      remove_elements_with_nil_values!

      finalize_modification
    end

    def merge_params(params)
      merge_request(params)

      self
    end

    private

    def merge_request(params)
      return merge_body(params) if same_root_tag?(params)

      merge_root_element(params)
    end

    def merge_body(value)
      @body = body.deep_merge(value)
    end

    def merge_root_element(value)
      body[root_tag] = body[root_tag].deep_merge(value)
    end

    def load_request_file
      File.read(filename)
    rescue StandardError
      puts "File #{filename} not found!"
    end

    def remove_elements_with_nil_values!(hash_to_remove_from = body)
      hash_to_remove_from.delete_if do |_element, value|
        remove_elements_with_nil_values!(value) if value.is_a?(Hash)

        value.nil?
      end
    end

    def same_root_tag?(params)
      params.keys.first.to_s == root_tag
    end

    def root_tag
      body.keys.first
    end

    def finalize_modification
      raise NotImplementedError
    end
  end
end
