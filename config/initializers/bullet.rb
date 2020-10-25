# frozen_string_literal: true

if defined?(Bullet)
  Rails.application.config.after_initialize do
    Bullet.enable = true
    Bullet.rails_logger = false
    Bullet.console = true
    Bullet.bullet_logger = true
  end
end
