require 'hublot_ar'

module HublotAr
  class Rails < Rails::Railtie
    initializer 'hublot_ar.initialize' do
      ActiveSupport::TimeWithZone.send :include, HublotAr
    end
  end
end
