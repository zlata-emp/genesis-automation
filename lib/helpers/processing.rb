# frozen_string_literal: true

class ProcessingHelper
  def self.transaction_id_param
    timestamp = Time.now.utc.strftime('%Y%m%d_%H%M%S')
    { transaction_id: "qa_checks-d#{timestamp}" }
  end

  def self.master_test_card_params
    { card_number:      '5555555555554444',
      cvv:              '123',
      expiration_month: '2',
      expiration_year:  (Time.now.year + 2).to_s }
  end
end
