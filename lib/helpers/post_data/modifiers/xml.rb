# frozen_string_literal: true

module PostData
  # XML request performer class
  class Xml < PostData::Body
    def element_value(xml, element)
      xml = Hash.from_xml(xml.to_s)
      return if xml.blank?

      xml[element]
    end

    def self.parse(content)
      Hash.from_xml(content).with_indifferent_access
    end

    private

    def parse_body
      @body ||= self.class.parse(load_request_file)
    end

    def finalize_modification
      key, value = body.first
      value.to_xml(root: key, dasherize: false)
    end
  end
end