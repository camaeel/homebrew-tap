class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.12"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ctx-darwin-arm64"
      sha256 "bb73241d9432f5bf27111d6d8b844c3764e6fc7de1fd8aeae2b9e3f3628b65b3"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ns-darwin-arm64"
        sha256 "964108b70839ed618bb04c545c7efe13a7ce8093255fc07b703436f406494807"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ctx-darwin-amd64"
      sha256 "ceff32ecc804ad3f82dd240db25e3a0a307aded8ce45ba0ad90b114191fc87f1"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ns-darwin-amd64"
        sha256 "6844c45dd8bdd039047794b6e1d01bf63dfc7968b39c5c539c0b0111fd66cd9a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ctx-linux-arm64"
      sha256 "c0c3e6df162776455949e603ccfafad328cac3cbc9845c1246cc8407b40bae2c"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ns-linux-arm64"
        sha256 "3cc515638537999b1012ee62cb29a61521baff38b5ac6b02ff41735caf976282"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ctx-linux-amd64"
      sha256 "49fef84d1810e5b782bdfaff1d3eb7791202e570fafd43fc3c7f0d7cc3852e6b"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.12/kubectl-ns-linux-amd64"
        sha256 "882d82c8ef987f1b671b83694a21367f5855d21682b983b26795da47ded3c3d0"
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
