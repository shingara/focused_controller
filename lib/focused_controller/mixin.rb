require 'focused_controller/action_name'
require 'active_support/concern'
require 'active_support/core_ext/string/conversions'
require 'active_support/core_ext/class/attribute'

module FocusedController
  module Mixin
    extend ActiveSupport::Concern

    included do
      class_attribute :allow_view_assigns
      self.allow_view_assigns = false
    end

    module ClassMethods
      def controller_path
        @focused_controller_path ||= name && name.sub(/\:\:[^\:]+$/, '').sub(/Controller$/, '').underscore
      end

      def call(env)
        action(FocusedController.action_name).call(env)
      end
    end

    def action_name
      self.class.name.demodulize.underscore
    end

    def method_for_action(name)
      FocusedController.action_name
    end

    def view_assigns
      if self.class.allow_view_assigns
        super
      else
        {}
      end
    end

    def run
    end
  end
end
