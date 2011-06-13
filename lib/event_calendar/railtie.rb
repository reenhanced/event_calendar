require 'event_calendar'
require 'event_calendar/calendar_helper'
require 'rails'

module EventCalendar
  class Railtie < Rails::Engine
    config.event_calendar = ActiveSupport::OrderedOptions.new

    initializer "event_calendar.configure" do |app|
      EventCalendar.configure do |config|
        config.border = app.config.event_calendar[:border] || "#d5d5d5"
        config.day_names_bg = app.config.event_calendar[:day_names_bg] || "#303030"
        config.day_names_text = app.config.event_calendar[:day_names_text] || "white"
        config.day_header_bg = app.config.event_calendar[:day_header_bg] || "#ecede2"
        config.day_header_text = app.config.event_calendar[:day_header_text] || "#444"
        config.today_bg = app.config.event_calendar[:today_bg] || "#ffd"
        config.today_header_bg = app.config.event_calendar[:today_header_bg] || "#d7d7ba"
        config.other_month_header_bg = app.config.event_calendar[:other_month_header_bg] || "#efefef"
        config.other_month_header_text = app.config.event_calendar[:other_month_header_text] || "#777"
      end
    end

    initializer :after_initialize do
      if defined?(ActionController::Base)
        ActionController::Base.helper EventCalendar::CalendarHelper
      end
      if defined?(ActiveRecord::Base)
        ActiveRecord::Base.extend EventCalendar::ClassMethods
      end
    end
  end
end

# Support other ORMs
require 'event_calendar/orm/mongoid' if defined? Mongoid