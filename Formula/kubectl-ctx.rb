class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ctx-darwin-arm64"
      sha256 "acb849bed845c2e858b247e5c11b2bc62808249fbabfe18c2dc36855b888f7de"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ns-darwin-arm64"
        sha256 "cec21699e842e74624d6928105d0fa5b5f94e7dc1d5a08067c1cd8b5f2ba172c"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ctx-darwin-amd64"
      sha256 "d45202f838868474deb9f85c349071f547eff9dfe67bead5b076c3daf68f392a"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ns-darwin-amd64"
        sha256 "219ae7f7a6d84f8e63363f98d023960edbaa75e0210f97354875e3fcc3822f6e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ctx-linux-arm64"
      sha256 "b592822fd8a1bdc5bfc25d548e890a5d18f7e97a261d086e753ff6e9c3a62c62"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ns-linux-arm64"
        sha256 "f283f99e3b8466fd6edfbdd8975280fc07c4311d2e7a2977e4d5ba694915d135"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ctx-linux-amd64"
      sha256 "809aa2fa21225b5a487f16448a38930fe5af8085e6d490a5c77703274662b57f"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.6/kubectl-ns-linux-amd64"
        sha256 "e3342778bb6cc543eeb76c8c6058095bf0473a9e4915d71fec274f3a1eed2cbc"
      end
    end
  end

  conflicts_with "kubectx", because: "both install kubectl-ctx and kubectl-ns binaries"

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
