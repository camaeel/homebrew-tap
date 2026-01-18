class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.0-alpha7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ctx-darwin-arm64"
      sha256 "f2b2957ab8f4e7bbfb8bf20946c8304363e822df114154735ecbb111e20b4031"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ns-darwin-arm64"
        sha256 "3b88cd9a9d9de6d96d890ed4d30cfd0f8c677f84ad01d0b919dced8cc36b8b60"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ctx-darwin-amd64"
      sha256 "1b58a71bdeb926a72cc772b9ae9952683efbd7f8e762a454843dbd2c945dc925"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ns-darwin-amd64"
        sha256 "314d60a5839d8a031cd61b77fdd57f1c8370a0b63ceaff62dd1714bed96b6ea6"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ctx-linux-arm64"
      sha256 "f69b0cae041f35548f54e8146ca039c087263353438a00b549a3144a41f04a92"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ns-linux-arm64"
        sha256 "3b88cd9a9d9de6d96d890ed4d30cfd0f8c677f84ad01d0b919dced8cc36b8b60"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ctx-linux-amd64"
      sha256 "86636efc2b4ffd4af7fa1c3ad245d0e0a5a3d575a107848b72d96ef3b5874581"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha7/kubectl-ns-linux-amd64"
        sha256 "75e485121202a7103ec00bc20e42397ac0a3abff1bced38ec4a7387d1250fa71"
      end
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    suffix = "\#{os}-\#{arch}"

    bin.install "kubectl-ctx-\#{suffix}" => "kubectl-ctx"

    resource("kubectl-ns").stage do
      bin.install "kubectl-ns-\#{suffix}" => "kubectl-ns"
    end
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/kubectl-ctx --version")
    assert_match version.to_s, shell_output("\#{bin}/kubectl-ns --version")
  end
end
