# frozen_string_literal: true

class Config
  LOGGER_LEVEL          = Logger::WARN
  REQUESTS_DIR          = 'requests'
  TRANSACTION_ID_PREFIX = 'qa_checks-'

  # This seems like a hack, probably it will be better to just list them in the Environment class
  def self.dirs_containing_spec_files
    dirs_defined_in_env_list = Environment.constants - Config.constants
    dirs_containing_specs_list = dirs_defined_in_env_list.each(&:to_s).join(',').downcase

    dirs_containing_specs_list = add_processing_subdirs(dirs_containing_specs_list)

    add_wpf_subdirs(dirs_containing_specs_list)
  end

  def self.add_processing_subdirs(dirs_containing_specs_list)
    if Environment.const_defined?(:PROCESSING)
      processing_subdirs = Environment::PROCESSING.keys.each(&:to_s).join(',processing/').downcase
      dirs_containing_specs_list = dirs_containing_specs_list.gsub 'processing', "processing/#{processing_subdirs}"
    end

    dirs_containing_specs_list
  end

  def self.add_wpf_subdirs(dirs_containing_specs_list)
    if Environment.const_defined?(:WPF)
      wpf_subdirs = Environment::WPF.keys.each(&:to_s).join(',wpf/').downcase
      dirs_containing_specs_list = dirs_containing_specs_list.gsub 'wpf', "wpf/#{wpf_subdirs}"
    end

    dirs_containing_specs_list
  end
end
