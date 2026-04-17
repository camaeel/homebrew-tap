class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ctx-darwin-arm64"
      sha256 "542723812770d074a750d1180bf4b5567336f0fe298ff2528740065f32d2af10"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ns-darwin-arm64"
        sha256 "bf0d052c8b3ebf8a470a2c4242bbaceed79d3ed8ab2bde9ec218d980f4815fb4"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ctx-darwin-amd64"
      sha256 "19f664d8b1d2efa1f05db83227824b09faa3d55e6b6f5ab8b4e24381ccd6a4f5"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ns-darwin-amd64"
        sha256 "37ba02881490984ee4a6b6ef0a89dc547abc2dd333e49ce8930a011070356ff5"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ctx-linux-arm64"
      sha256 "a6e14fd2d4a563296d634d2ab29763cbcea126fdc9fab0fb539d15df2864329d"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ns-linux-arm64"
        sha256 "70aa3a4b95fa82bc156b9e40d4b3f48d08de5d05cf8ad4f8bde32436950dd6ae"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ctx-linux-amd64"
      sha256 "e4125a5e509e0750ef3219b76a2bb3ad7dd5d46ec37d26fb6d19cb170b89e0a5"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.8/kubectl-ns-linux-amd64"
        sha256 "cc225b09485bb17722187b25d5d3f2b3196dccc8d9a6640330486815e9f54cb3"
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
