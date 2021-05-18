# frozen_string_literal: true

require './config/config'

class Environment < Config
  WPF = {
    omnipay: {
      processing_url: 'https://staging.wpf.emerchantpay.net/wpf',
      consumer_id:    '52039',
      consumer_email: 'card.holder@example.com',
      api_login:      'f7162ca048e47fb3e710bc206644e1f0dc936e86',
      api_password:   'e72c988fd44bacdb78e7c5ae09e2e1bf6de902e7' } }.with_indifferent_access.freeze
end

require './config/config_rspec'
