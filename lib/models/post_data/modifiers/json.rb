module PostData
  # JSON data modifier
  class Json < PostData::Body
    def element_value(json, element)
      json = JSON.parse json
      return if json.blank?

      json[element]
    end

    def self.parse(content)
      JSON.parse(content).with_indifferent_access
    end

    private

    def parse_body
      @body ||= self.class.parse(load_request_file)
    end

    def finalize_modification
      body.to_json
    end
  end
end
