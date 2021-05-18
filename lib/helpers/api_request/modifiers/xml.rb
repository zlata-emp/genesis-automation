# frozen_string_literal: true

module APIRequest
  # XML request performer class
  class Xml < APIRequest::Body
    def element_value(xml, element)
      xml = Hash.from_xml(xml.to_s)
      return if xml.blank?

      xml[element]
    end

    def self.parse(content)
      XmlSimple.xml_in(
        content,
        KeepRoot:      true,
        AttrPrefix:    true,
        SuppressEmpty: true,
        KeyToSymbol:   true,
        ForceArray:    false
      ).with_indifferent_access
    end

    private

    def parse_body
      @body ||= self.class.parse(load_request_file)
    end

    def finalize_modification
      XmlSimple.xml_out(body, RootName: nil, SuppressEmpty: true, AttrPrefix: true)
    end
  end
end
