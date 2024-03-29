# frozen_string_literal: true

require './config/config'
# require './config/stg_psp'
require './config/local'

# Custom env constants are designed to help in specific ticket testing.
# Note: Can NOT be used for local, because of the very rare ocations that tickets need to be tested on local setup.
#
# before running tests with
#   **<code>rspec -r './config/ticket'</code>**
# make sure you've selected the correct env variables for TICKET, SUB_DOMAIN and DOMAIN
#
class Environment < Config
  # overwrite config.pattern with dirs for the ticket
  # format is comma separated list of dir names
  def self.dirs_containing_spec_files
    %w[consumer ui].each(&:to_s).join(',').downcase
  end

  TICKET                = 'f2020022002'
  TRANSACTION_ID_PREFIX = "#{Dir.home.split('/').last}_#{TICKET}-"
end

require './config/config_rspec'
