# frozen_string_literal: true

class Environment
  BASE_URL = 'http://127.0.0.1'

  # Example how the config from sanity checks may look as ruby constant

  # WPF = {
  #   processing_url: "#{ENV_URL}:3003",
  #   gateways: %w[omnipay]
  # }

  # CONSUMER = {
  #   processing_url: "#{ENV_URL}:3001/v1",
  #   api_login: '846ff9581b9a999669787d3a4f9eee54200fd3ae',
  #   api_password: 'e,,9DV80eBRpyKXBD,anwFxWfdArop8RJ3JhpesX'
  # }

  # ISSUING = {
  #   processing_url: "#{ENV_URL}:3001/v1/issuing",
  #   processing_token: 'A-HkhdnM4dgXN4ukUmstGrD00Q7ZjKKbw-aCRGBI18g',
  #   processing_providers: [paynetics, ppro, transact, gps]
  # }

  # TOKENIZATION = {
  #   processing_url: "#{ENV_URL}:3001/v1",
  #   consumer_id: 2,
  #   consumer_email: 'no_reply@emerchantpay.com',
  #   api_login: '846ff9581b9a999669787d3a4f9eee54200fd3ae',
  #   api_password: 'e,,9DV80eBRpyKXBD,anwFxWfdArop8RJ3JhpesX'
  # }

  # TRANSACTIONS = {
  #   processing_url: "#{ENV_URL}:3001/process",
  #   bogus: {
  #     request_params: {
  #       consumer_id: 1,
  #       credit_card_token: {
  #         visa: 'a82c99ec-cef4-4f95-91b9-366ae3b87b2c',
  #         master: '635459bf-3d34-4e60-9426-9c067bfd3e22',
  #         intl_maestro: 'd4c59a2a-baf0-498c-9a62-8548dafde693'
  #       },
  #       credit_card_token_id: {
  #         visa: 'ea94fc32ab31193871fa4f123618aa19',
  #         master: 'e467188059d01d1b2263190a02caa28a'
  #       }
  #     },
  #     name: 'bogus_terminal_name',
  #     token: '37d18d69605113fcd4e454b664d9846a5a4128c1',
  #     api_login: '846ff9581b9a999669787d3a4f9eee54200fd3ae',
  #     api_password: 'e,,9DV80eBRpyKXBD,anwFxWfdArop8RJ3JhpesX'
  #   },
  #   omnipay: {
  #     request_params: {
  #       consumer_id: 1,
  #       credit_card_token: {
  #         visa: 'e3aa8037-3f96-4283-a651-ea469e207aa8',
  #         master: '635459bf-3d34-4e60-9426-9c067bfd3e22'
  #       },
  #       credit_card_token_id: {
  #         visa: '5f1903ff8b74be82932363dd031b91ee',
  #         master: '2496b3e36cfae65b33a7e53bf27578e2'
  #       }
  #     },
  #     name: 'omnipay_terminal',
  #     token: '95d9cc3a0dff1437e6b41e2855c1429970136e5c',
  #     api_login: '78b271fdb8e3ce48afb0f65261ae7ce2ba76e3da',
  #     api_password: 'DY,4WEVABtDV3r0z9FcKQ5AiAs8txpcF3xtJaq0l'
  #   },
  #   apc: {
  #     name: 'unexisting Apc',
  #     token: 'broken349b13fedac8b03eafa45a5b7693d6d40cc6d35a',
  #     api_login: 'brokenc801a4982b7e3791d7d02ff47739a140f0e15d4b',
  #     api_password: 'brokenYGnX9w5LbbjIj42riU37fUdMMIpvjane94zYqk6f'
  #   },
  #   elavon: {
  #     name: 'unexisting Elevon',
  #     token: 'broken349b13fedac8b03eafa45a5b7693d6d40cc6d35a',
  #     api_login: 'brokenc801a4982b7e3791d7d02ff47739a140f0e15d4b',
  #     api_password: 'brokenYGnX9w5LbbjIj42riU37fUdMMIpvjane94zYqk6f'
  #   }
  # }
end
