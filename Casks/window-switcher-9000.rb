cask "window-switcher-9000" do
  version "1.4.12"
  sha256 "d829bb150a9f9a5f9f80673505585284387abfeae158b57f2d725ee06bf01629"

  url "https://github.com/jqyDee/WindowSwitcher9000/releases/download/v#{version}/WindowSwitcher9000.zip"
  name "window-switcher"
  desc "this is a small window switcher for macOS, relying heavily on yabai"
  homepage "https://github.com/jqyDee/WindowSwitcher9000"

  app "WindowSwitcher.app"
end
