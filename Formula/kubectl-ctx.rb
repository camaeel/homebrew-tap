class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.0-alpha6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-arm64"
      sha256 "2d27716d2b1f7d1b46b477e9710aa0635c0900f85e47ce1a796af1f358f4da96"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ns-darwin-arm64"
        sha256 "f652dbd04b0c971be49e2e11a9986e6f082736024c5b417a1d89ef20d38896ca"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-amd64"
      sha256 "b02b970ac836f7e473da1d19e0db960bf3173b463d5383175a7af2fe0ff91705"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ns-darwin-amd64"
        sha256 "67e7b6e2e61f4757c25372c40726d39255a3078e3200544ba8272e3c0eacfdc3"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-arm64"
      sha256 "f84ed7572085b074af6d1330fd5f2de718de388cfbbc8652f4670ce2c9654074"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ns-linux-arm64"
        sha256 "c355c3d5a9f2f47b4ba0f62e5af26ffd5539d8822c301e30886c5832b8fae721"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-amd64"
      sha256 "5453b3e0da326dd65c52e800440ac940e71275929a8b6e9739eb28bef60acaf5"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ns-linux-amd64"
        sha256 "0d0550262ce187205534d1cf612ea4976d0b6f68c381ba33b3dfc10b8eb966b8"
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
