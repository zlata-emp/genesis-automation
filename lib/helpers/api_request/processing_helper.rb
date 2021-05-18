# frozen_string_literal: true

module APIRequest
  class ProcessingHelper
    EXPIRATION_YEAR      = (Time.now.year + 2).to_s
    EXPIRATION_MONTH     = '2'
    EXPIRATION_MONTH_WPF = 'Feb'
    CVV                  = '123'
    CARD_HOLDER          = 'Card h\'Older'

    def self.transaction_id_param
      timestamp = Time.now.utc.strftime('%Y%m%d_%H%M%S_%L')
      { transaction_id: "#{Environment::TRANSACTION_ID_PREFIX}d#{timestamp}" }
    end

    def self.transaction_types(types)
      types = types.map { |type| { '@name': type.to_s } }
      { transaction_types: { transaction_type: types } }
    end

    def self.wpf_card_params(card_number:,
                             card_holder: CARD_HOLDER,
                             exp_year: EXPIRATION_YEAR,
                             exp_month: EXPIRATION_MONTH_WPF,
                             cvv: CVV)
      { wpf_form_card_holder:        card_holder,
        wpf_form_card_number:        card_number,
        wpf_form_expiration_date_2i: exp_month,
        wpf_form_expiration_date_1i: exp_year,
        wpf_form_requires_cvv:       cvv }
    end

    def self.master_test_card_params
      { card_number:      '5555555555554444',
        cvv:              '123',
        expiration_month: EXPIRATION_MONTH,
        expiration_year:  (Time.now.year + 2).to_s }
    end

    def self.visa_test_card_3d_async_params
      { card_number:      '4711100000000000',
        cvv:              '123',
        expiration_month: EXPIRATION_MONTH,
        expiration_year:  EXPIRATION_YEAR }
    end
  end
end
