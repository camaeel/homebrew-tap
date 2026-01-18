class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.0-alpha8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ctx-darwin-arm64"
      sha256 "11cfd932b65ee3548de9142e8867341354a30d37be068ada8033aa0727600ca5"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ns-darwin-arm64"
        sha256 "81c99a8a12c04d428902ce8a11173337bfb37abdc31c1c1b53f87652b45b3912"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ctx-darwin-amd64"
      sha256 "78189eea61f45e6ff957f99f99f5a793f874c1071614d2e64dc73533d58cbe14"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ns-darwin-amd64"
        sha256 "ce70ae49bf6481540432978fac5f8491f99974dc8b90e6909075b11c35a5b70a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ctx-linux-arm64"
      sha256 "61b837507f560c4af5e7a620e674ef536ce6c2ca04fe69488d958ff961a3ca81"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ns-linux-arm64"
        sha256 "81c99a8a12c04d428902ce8a11173337bfb37abdc31c1c1b53f87652b45b3912"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ctx-linux-amd64"
      sha256 "637abef6010543fb827958aa435672b473dc9c998b690e03b2ca2d19d874e2b4"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha8/kubectl-ns-linux-amd64"
        sha256 "22f7068480d20b8502605eae3271051b7cc917aae22184606b2351671088e7c4"
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
