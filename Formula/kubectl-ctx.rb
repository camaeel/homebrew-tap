class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ctx-darwin-arm64"
      sha256 "e968dcc7122cbed902de57046eac2ba1dd2b13e0996230aca17dbf6c08f331eb"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ns-darwin-arm64"
        sha256 "b293343670725a19068fb9c215f894dffc4b814a69b10dbb66f7cb9367867a81"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ctx-darwin-amd64"
      sha256 "be4e601263152d6b41b1eb2f5ff3f504b84137d4323616378eeb854909f9af4c"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ns-darwin-amd64"
        sha256 "8fea4ea9e058e4483ac6490465a2c1b48f3266c513015afdd59a558770c6316c"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ctx-linux-arm64"
      sha256 "98397cc64bc19ea05647704ce851bf1400ffdcf6717b585718a191c5c8962621"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ns-linux-arm64"
        sha256 "60f59197741ae0fcb94397bad6721b295560d31913609a86cef3f68bd1dd772e"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ctx-linux-amd64"
      sha256 "47f9192403a8b75a1e798583400dac2e0e31bf0e239c4645e9eb6e1d0633c7e9"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.10/kubectl-ns-linux-amd64"
        sha256 "889b086d0248c96227e98d7d99b632438ecba2d4312116d39ae70ce4b526f8ad"
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
