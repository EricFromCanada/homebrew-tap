class ConsulEnterprise < Formula
  desc "Consul Enterprise"
  homepage "https://www.consul.io"
  version "1.13.2+ent"

  if OS.mac? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/consul/1.13.2+ent/consul_1.13.2+ent_darwin_amd64.zip"
    sha256 "ab58cc9dd3ff5fe82e468423e7a27bfa8d2b494980394d8685505d85e1a2b3e8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.hashicorp.com/consul/1.13.2+ent/consul_1.13.2+ent_darwin_arm64.zip"
    sha256 "01be28011910dc4f2efb3b347c40bfbc59d6b7d25641f3f0d2dfc767c76ab6b2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/consul/1.13.2+ent/consul_1.13.2+ent_linux_amd64.zip"
    sha256 "5442ab15f7374c3488d5ea06a8fb72b97a19a0096b6fc587c7608387e28ab01d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/consul/1.13.2+ent/consul_1.13.2+ent_linux_arm.zip"
    sha256 "b29f186f4ca3a33b6851da74455daa94308404bcbecbd95087b1cc5f95267711"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/consul/1.13.2+ent/consul_1.13.2+ent_linux_arm64.zip"
    sha256 "cb76403a31ecec5e945b56d91aed71f1fad0ee68102a4afead2f0c42274374d5"
  end

  conflicts_with "consul-enterprise"

  def install
    bin.install "consul"
  end

  plist_options manual: "consul agent -dev -bind 127.0.0.1"

  def plist; <<~EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
        <string>#{opt_bin}/consul</string>
        <string>agent</string>
        <string>-dev</string>
        <string>-bind</string>
        <string>127.0.0.1</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>#{var}</string>
    <key>StandardErrorPath</key>
    <string>#{var}/log/consul.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/consul.log</string>
</dict>
</plist>

EOS
  end

  test do
    system "#{bin}/consul --version"
  end
end
