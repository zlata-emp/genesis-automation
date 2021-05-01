# frozen_string_literal: true

# Custom env constants are designed to help in specific ticket testing.
# Note: Can NOT be used for local, because of the very rare ocations that tickets need to be tested on local setup.
#
# before running tests with
#   **<code>rspec -r './config/ticket'</code>**
# make sure you've selected the correct env variables for TICKET, SUB_DOMAIN and DOMAIN
#
require './config/staging_psp'
class Environment
  TICKET                = 'f2020022002'
  TRANSACTION_ID_PREFIX = "#{Dir.home.split('/').last}_#{TICKET}-"
end
