describe Fastlane::Actions::InstallonairAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The installonair plugin is working!")

      Fastlane::Actions::InstallonairAction.run(nil)
    end
  end
end
