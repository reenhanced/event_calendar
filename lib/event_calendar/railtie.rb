require 'event_calendar'
require 'event_calendar/calendar_helper'
require 'rails'

module EventCalendar
  class Railtie < Rails::Engine
    config.event_calendar = ActiveSupport::OrderedOptions.new

    initializer "event_calendar.configure" do |app|

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