require 'fastlane/action'
require_relative '../helper/installonair_helper'

module Fastlane
  module Actions

    module SharedValues
      UPLOADED_FILE_LINK_TO_INSTALL_ON_AIR = :UPLOADED_FILE_LINK_TO_INSTALL_ON_AIR
    end

    class InstallonairAction < Action

      def self.run(params)
        UI.message("The installonair plugin is working!")
      end

      def self.description
        "Install On Air plugin integrated with Fastlane"
      end

      def self.authors
        ["QuocTA-Amela"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Install On Air plugin integrated with Fastlane"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "INSTALLONAIR_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
