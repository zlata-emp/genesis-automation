# frozen_string_literal: true

class ProcessingHelper
  def self.transaction_id
    timestamp = Time.now.utc.strftime('%Y%m%d_%H%M%S')
    "qa_checks-d#{timestamp}"
  end
end
