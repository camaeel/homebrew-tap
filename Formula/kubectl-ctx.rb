class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.11"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ctx-darwin-arm64"
      sha256 "a671c30af05649ddca290e366442d713649f8c201c637b3ec5aeaaa56b3ebc51"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ns-darwin-arm64"
        sha256 "59be3abc118f6149e7bb3f65a547112b6b765c258bb34a0ac24b0c940733a5b6"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ctx-darwin-amd64"
      sha256 "b95f9811d4242484f24575461d39f2b60f102c9f61c4b0397187d8bcde96f931"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ns-darwin-amd64"
        sha256 "b469d1554a9e224aa8b7963e398a82dfdd643c21c8cff28b53e010f507471394"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ctx-linux-arm64"
      sha256 "92831ff1a6794416396b2999d0e8b0405d2c47a1153b808271129762e0b51569"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ns-linux-arm64"
        sha256 "6a62d87f162b629424854478a7bac7e863c8b1b3a6ec46aa5cdb51c51aae76cb"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ctx-linux-amd64"
      sha256 "f1bd3e2b7324709eb4030c3b0b797df71d87c195e21cbd64ef90eec6be3c0bf7"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.11/kubectl-ns-linux-amd64"
        sha256 "fd0f345526e4facf3cc67714bd691eb2dc345ab8897e5761e4b22ce8251bd9f3"
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
