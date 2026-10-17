class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ctx-darwin-arm64"
      sha256 "45778c63dba5344177733864886c58187b967026f5bf75423a483d66c0f04948"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ns-darwin-arm64"
        sha256 "c57ba29150e176a65181c9b77bff1cdce9116cb698f7ed00e00b7eae8cd0028a"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ctx-darwin-amd64"
      sha256 "29fadd1270b9e67c70e15d9d0337603e75f31f063739229f3f60e49710c1ca68"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ns-darwin-amd64"
        sha256 "7dc52c5b6636e0992825002e91a98c9d3a502f76e40e6e05207fd2c0fa6374e2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ctx-linux-arm64"
      sha256 "34f80c3ec7367438b3aeecd3152ab5e45202fce6e305920a34b4a8ec8c05e456"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ns-linux-arm64"
        sha256 "1196b483796eb6476f3d1308de8b3ecfad49ab0deb57767cb87617336eb0035f"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ctx-linux-amd64"
      sha256 "5e873c2784d8ce850110f5f529be40082cc2412cec3ecacf3ae12dc769daf0b4"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.13/kubectl-ns-linux-amd64"
        sha256 "ebad77985126dc7169ba1039ba0c7de4737fcf366b3ef93a6ca9d660b1b2e35a"
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
