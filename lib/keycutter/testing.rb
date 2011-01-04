require 'fakeweb'

FakeWeb.allow_net_connect = false
FakeWeb.register_uri :get, "https://rubygems.org/api/v1/api_key", {
                        :body => ENV['FAKEWEB_BODY'],
                        :status => [ENV['FAKEWEB_STATUS'], ENV['FAKEWEB_MESSAGE']]
                     }
