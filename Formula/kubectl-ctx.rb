class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.1"
  license "Apache-2.0"

  conflicts_with "kubectx", because: "both install kubectl-ctx and kubectl-ns binaries"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ctx-darwin-arm64"
      sha256 "138d9261377e11d381ac76b7771ad1d9017488e3f9f12e610dad2be1eb777240"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ns-darwin-arm64"
        sha256 "d34ed84589c7c1daa60ce36c1b52182f9433e39db5bcb16600ea20fda41b8cef"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ctx-darwin-amd64"
      sha256 "f1c7952ceb829586a1940b520889c8ce5683e9a72a651c3a1154d245d33596f1"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ns-darwin-amd64"
        sha256 "9eb110863e93f7025d4608738bd8dc094cd1a985c874345d5f6a2f2aa5aecdaf"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ctx-linux-arm64"
      sha256 "4503a4931ebb10efc890e0be4fc7a3367fbec76ea18f6443aea695fa0614eee1"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ns-linux-arm64"
        sha256 "d34ed84589c7c1daa60ce36c1b52182f9433e39db5bcb16600ea20fda41b8cef"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ctx-linux-amd64"
      sha256 "6896419faef969b87e2e1df12f3fbe2dff95180b83f613136dd97c97f3345c3b"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.1/kubectl-ns-linux-amd64"
        sha256 "61327ecde7ac8c23d9a51846ffce112b0e2b78ca85ad6af841012d8440287978"
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
