class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ctx-darwin-arm64"
      sha256 "c6c53bb6f1182cac5bf53634b63c5674be8968e2dd6699f956953305a8756f4c"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ns-darwin-arm64"
        sha256 "44c0beab845a2a08bad6f892e4f754692be4569f7b2560a247569489d9dec6fe"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ctx-darwin-amd64"
      sha256 "0110143e84715c42caa0e2b7e41f9e51690c72b1310d30fb8745403ea52be37e"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ns-darwin-amd64"
        sha256 "23b0acef9c1f3f09ef806dfe3329de705b6f6419e0bb3031b755434f7b94834b"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ctx-linux-arm64"
      sha256 "87258597d0bf379d2d4a8519602f32a9b555248914190710bdfed09a98aa266d"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ns-linux-arm64"
        sha256 "44c0beab845a2a08bad6f892e4f754692be4569f7b2560a247569489d9dec6fe"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ctx-linux-amd64"
      sha256 "d31245016124955c8429e496bb25b669d9573b4ee7ad6960361eabb604ce4f14"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.3/kubectl-ns-linux-amd64"
        sha256 "7b98289c680257b2a35209b6d013ae0860695168e5ec009a9c74fe0f10af5920"
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
