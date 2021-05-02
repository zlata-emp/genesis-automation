# frozen_string_literal: true

class Constants
  REQUESTS_DIR          = 'requests'
  TRANSACTION_ID_PREFIX = 'qa_checks-'

  # This seems like a hack, probably it will be better to just list them in the Environment class
  def self.dirs_containing_spec_files
    dirs_defined_in_env_list = Environment.constants - Constants.constants
    dirs_defined_in_env_list = dirs_defined_in_env_list.each(&:to_s).join(',').downcase
    return dirs_containing_specs_list unless Environment.const_defined?(:PROCESSING)

    processing_subdirs = Environment::PROCESSING.keys.each(&:to_s).join(',').downcase

    "#{dirs_defined_in_env_list}}{,/}{,#{processing_subdirs}"
  end
end
