class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.0-alpha3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-arm64"
      sha256 "8cac85eef22d990a049878ab36d57794d1ab1e8cd1807d9b101d1e61c43594dd"
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-amd64"
      sha256 "66b66c0e7f8553b5fb7aad1cbd61dd1165043866116a3ae8eefc89edd55663d1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-arm64"
      sha256 "92ab07eb63649e32e06c56f58f0897602d123fc8479274f132c6454f57028e53"
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-amd64"
      sha256 "1856a950df6e9e8a9e373e7f24cf634cb9fbc4c7dc40646bd3ea8fd41260a4d2"
    end
  end

  resource "kubectl-ns-darwin-arm64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha3/kubectl-ns-darwin-arm64"
    sha256 "dbed2cdd5b82f9ab77eaba3b460b8e0322dffd5d25a25dd5f87b74b2f4e6b1e5"
  end

  resource "kubectl-ns-darwin-amd64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha3/kubectl-ns-darwin-amd64"
    sha256 "8ce58b3832fcd1938d6e6644df7c0f0af8916a94a26033a87d7072f817d271e8"
  end

  resource "kubectl-ns-linux-arm64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha3/kubectl-ns-linux-arm64"
    sha256 "5e2928ad8c819c2111ba2b702c2e20e19828fc55eb3a697d459c55524d1293c0"
  end

  resource "kubectl-ns-linux-amd64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha3/kubectl-ns-linux-amd64"
    sha256 "469e583f214d10beb9bb155a5116712d39cceed2d11b326b8c6b1f3263a594ab"
  end

  def install
    # Determine platform suffix
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    suffix = "#{os}-#{arch}"
    
    # Install kubectl-ctx (main binary from URL)
    bin.install "kubectl-ctx-#{suffix}" => "kubectl-ctx"
    
    # Install kubectl-ns (from resource)
    resource("kubectl-ns-#{suffix}").stage do
      bin.install "kubectl-ns-#{suffix}" => "kubectl-ns"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kubectl-ctx --version")
    assert_match version.to_s, shell_output("#{bin}/kubectl-ns --version")
  end
end
