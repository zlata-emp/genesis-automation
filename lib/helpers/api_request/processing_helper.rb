# frozen_string_literal: true

module APIRequest
  class ProcessingHelper
    def self.transaction_id_param
      timestamp = Time.now.utc.strftime('%Y%m%d_%H%M%S_%L')
      { transaction_id: "#{Environment::TRANSACTION_ID_PREFIX}d#{timestamp}" }
    end

    def self.master_test_card_params
      { card_number:      '5555555555554444',
        cvv:              '123',
        expiration_month: '2',
        expiration_year:  (Time.now.year + 2).to_s }
    end

    def self.visa_test_card_3d_async_params
      { card_number:      '4711100000000000',
        cvv:              '123',
        expiration_month: '2',
        expiration_year:  (Time.now.year + 2).to_s }
    end
  end
end
