class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def errors_messages
    errors.full_messages.join(", ")
  end
end
