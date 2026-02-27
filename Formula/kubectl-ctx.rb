class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ctx-darwin-arm64"
      sha256 "bba5cf65148626aa3921f8038d542ec41ade394c57df5fc9786e0b5bf258c7b9"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ns-darwin-arm64"
        sha256 "0bb3eda67da3159cdbdfe5a743036a06eb6ce58c54e29fabd299875aa75064a7"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ctx-darwin-amd64"
      sha256 "9ea96f552becff07f44a782c9bc95ddc30fdc790a3ac4d7148b1889870b5286f"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ns-darwin-amd64"
        sha256 "ca4b03141a1ae1ad236f798fb4c82cfd92586c6ffa545b813da63d9ec8402be1"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ctx-linux-arm64"
      sha256 "e50ab9adefa9be46cb3542a7a0bb423a210fc9ed826eed7d7d73b99fde7b0fd0"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ns-linux-arm64"
        sha256 "0d404c2d66f698403961f3199a001d7c195273f5d1fd398dc0699912b830481c"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ctx-linux-amd64"
      sha256 "388eaf8afbb375c905ccb65f0ed52de9a0723689021fe8b4b138fff5907ad99d"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.7/kubectl-ns-linux-amd64"
        sha256 "37049209f7d9376ceed673cab59536b729918bd8a6c3cf84a458562e94542801"
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
