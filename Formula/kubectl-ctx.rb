class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ctx-darwin-arm64"
      sha256 "d2a3af5b0b6be277e410e30fb7f1c0e339d16d1676bddf368c8f00a408548e7f"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ns-darwin-arm64"
        sha256 "fdd7d76f621a17cbeb40fe2c23eb431d567027d1d3e7c795adacd6285aae138d"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ctx-darwin-amd64"
      sha256 "720b778e445c48ba2da413359d031473219c7192b9cfb8aad3281b06057adbfe"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ns-darwin-amd64"
        sha256 "236f44d19fe4d49015c7c16140ac7b30e14c407d6704993d1314844ff166022c"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ctx-linux-arm64"
      sha256 "686557a09210a9bdbac51843997a48b8841e18df4670713362d46a3621286adc"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ns-linux-arm64"
        sha256 "e99f0463c57e344c387db08a203580b773712cf29acb46e47f6069a33f37ce7b"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ctx-linux-amd64"
      sha256 "79291f3c7dce950409192340a68b8a86b2f89dd20418dd081b4bb36ee443cee3"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.16/kubectl-ns-linux-amd64"
        sha256 "96a53fb1b1135611cf1a9af8e9221fe7efe5c42e197890187a69171066226fcd"
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
