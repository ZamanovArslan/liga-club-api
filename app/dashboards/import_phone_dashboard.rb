# app/dashboards/stat_dashboard.rb
require "administrate/custom_dashboard"

class ImportPhoneDashboard < Administrate::CustomDashboard
  resource "ImportPhones" # used by administrate in the views
end
