require 'fastlane/action'
require_relative '../helper/installonair_helper'

module Fastlane
  module Actions

    module SharedValues
      UPLOADED_FILE_LINK_TO_INSTALL_ON_AIR = :UPLOADED_FILE_LINK_TO_INSTALL_ON_AIR
    end

    class InstallonairAction < Action

      UPLOAD_URL = "https://fupload.installonair.com/ipafile/"
      STATUS_CHECK_URL = "https://upload.diawi.com/status"
      DIAWI_FILE_LINK = "https://i.diawi.com"

      def self.run(params)
        UI.message("The installonair plugin is working!")
      end
      def self.description
        "Install On Air plugin integrated with Fastlane"
      end
      def self.authors
        ["QuocTA-Amela"]
      end

      Actions.verify_gem!('rest-client')
      require 'rest-client'
      require 'json'

      if options[:file].nil?
        UI.important("File didn't come to install_on_air_plugin. Uploading is unavailable.")
        return
      end
      if options[:token].nil?
        UI.important("Install on air token is nil - uploading is unavailable.")
        UI.important("Try to upload file by yourself. Path: #{options[:file]}")
        return
      end

      upload_options[:_token] = options[:token]
      upload_options[:file] = File.new(options[:file], 'rb')
      UI.success("Start uploading file to Install On Air. Please, be patient. This could take some time.")
      response = RestClient.post(UPLOAD_URL, upload_options)

      begin
        response
      rescue RestClient::ExceptionWithResponse => error
          UI.important("Faild to upload file to diawi, because of:")
          UI.important(error)
          UI.important("Try to upload file by yourself. Path: #{options[:file]}")
          return
      end

      job = JSON.parse(response.body)['job']
      
      if job
          timeout = options[:timeout].clamp(5, 1800)
          check_status_delay = options[:check_status_delay].clamp(1, 30)

          if check_status_delay > timeout
              UI.important("`check_status_delay` is greater than `timeout`")
          end

          UI.success("Upload completed successfully.")
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Install On Air plugin integrated with Fastlane"
      end
      
      def self.default_file_path
          platform = Actions.lane_context[SharedValues::PLATFORM_NAME]
          ios_path = Actions.lane_context[SharedValues::IPA_OUTPUT_PATH]
          android_path = Actions.lane_context[SharedValues::GRADLE_APK_OUTPUT_PATH]
          return platform == :ios ? ios_path : android_path 
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
