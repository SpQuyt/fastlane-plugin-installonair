require 'fastlane/action'
require_relative '../helper/installonair_helper'

module Fastlane
  module Actions

    module SharedValues
      UPLOADED_FILE_LINK_TO_INSTALL_ON_AIR = :UPLOADED_FILE_LINK_TO_INSTALL_ON_AIR
    end

    class InstallonairAction < Action

      UPLOAD_URL = "https://fupload.installonair.com/ipafile"

      def self.run(options)
        UI.message("The installonair plugin is working!")
        Actions.verify_gem!('rest-client')
        require 'rest-client'
        require 'json'
        require 'tty-spinner'
  
        if options[:file].nil?
          UI.important("File didn't come to install_on_air_plugin. Uploading is unavailable.")
          return
        end
        if options[:token].nil?
          UI.important("Install on air token is nil - uploading is unavailable.")
          UI.important("Try to upload file by yourself. Path: #{options[:file]}")
          return
        end
        
        UI.success("Start uploading file to Install On Air. Please, be patient. This could take some time.")
        spinner = TTY::Spinner.new("[:spinner] Uploading ...", format: :pulse_2)
        spinner.auto_spin
        payload = {
          _token: options[:token],
          ipafile: File.new(options[:file], 'rb')
        }
        response = RestClient.post(UPLOAD_URL, payload)
        begin
          response
        rescue RestClient::ExceptionWithResponse => error
          puts error.response
          UI.important("Failed to upload file to install on air, because of:")
          UI.important(error)
          UI.important("Try to upload file by yourself. Path: #{options[:file]}")
        end
        data = JSON.parse(response.body)['data']
        if data
          UI.message("Uploaded!")
          UI.success("File successfully uploaded to InstallOnAir. Link: #{data['link']}")
          Actions.lane_context[SharedValues::UPLOADED_FILE_LINK_TO_INSTALL_ON_AIR] = data['link']
          return
        end
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
      
      def self.default_file_path
          platform = Actions.lane_context[SharedValues::PLATFORM_NAME]
          ios_path = Actions.lane_context[SharedValues::IPA_OUTPUT_PATH]
          android_path = Actions.lane_context[SharedValues::GRADLE_APK_OUTPUT_PATH]
          return platform == :ios ? ios_path : android_path 
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :token,
                                            env_name: "INSTALL_ON_AIR_TOKEN",
                                         description: "API access token",
                                            optional: false),
          FastlaneCore::ConfigItem.new(key: :file,
                                  env_name: "INSTALL_ON_AIR_FILE",
                                description: "Path to .ipa or .apk file. Default - `IPA_OUTPUT_PATH` or `GRADLE_APK_OUTPUT_PATH` based on platform",
                                  optional: true,
                              default_value: self.default_file_path)
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
