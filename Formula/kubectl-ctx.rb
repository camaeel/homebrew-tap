class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.2"
  license "Apache-2.0"

  conflicts_with "kubectx", because: "both install kubectl-ctx and kubectl-ns binaries"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ctx-darwin-arm64"
      sha256 "6f6f34af71327656a86973882b312213e0f8c806d373f921167220626a52df22"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ns-darwin-arm64"
        sha256 "5c095abb0d531868715d5225b2e8294ee1d3aa6dd98bfc6bcd6f4c1eeed866e6"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ctx-darwin-amd64"
      sha256 "bad24205c3b09140803724bee52dd425dbbc38919481382452730bdb4f086c14"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ns-darwin-amd64"
        sha256 "455c9cfaed72b25c54518b9eebc0d8f5c978390038c2733b0c4fac651d885ada"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ctx-linux-arm64"
      sha256 "4e79b137875573af41f66358bbe2b594eeac8bc6c63a1bab05163b01a226ad70"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ns-linux-arm64"
        sha256 "5c095abb0d531868715d5225b2e8294ee1d3aa6dd98bfc6bcd6f4c1eeed866e6"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ctx-linux-amd64"
      sha256 "06c37f6a03e28fb9374c3a3aa2008bb49170b457ccac3168d58fc7d0b6509bb6"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.2/kubectl-ns-linux-amd64"
        sha256 "b5610de4fa3010e418badbfd6970b95ff1e6c6d57e545d869c61d11febb15ac0"
      end
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    suffix = "#{os}-#{arch}"

    bin.install "kubectl-ctx-#{suffix}" => "kubectl-ctx"

    resource("kubectl-ns").stage do
      bin.install "kubectl-ns-#{suffix}" => "kubectl-ns"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kubectl-ctx --version")
    assert_match version.to_s, shell_output("#{bin}/kubectl-ns --version")
  end
end
