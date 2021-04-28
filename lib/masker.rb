# frozen_string_literal: true

# This class is responsible for masking sensitive data on modifing and printing repsponses in the console
#
class Masker
  ELEMENT_TO_SETTINGS_FOR_MASKING_MAPPING = {
    card_number: { first: 6, last: 4 },
    cvv: { first: 0, last: 0 },
    expiration_month: { first: 0, last: 0 },
    expiration_year: { first: 0, last: 0 },
    consumer_id: { first: 0, last: 0 },
    token: { first: 0, last: 0 },
  }.with_indifferent_access.freeze

  def self.for(element, content)
    masking_setting = ELEMENT_TO_SETTINGS_FOR_MASKING_MAPPING[element]
    return content unless masking_setting.present?

    "#{content.first(masking_setting[:first])}#{'*' * 3}#{content.last(masking_setting[:last])}"
  end
end
