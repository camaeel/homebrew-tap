class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.9"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ctx-darwin-arm64"
      sha256 "9dbe6149c6937af13f24d2ca6b5850b90ec3def362f31d5a4d1b1f7dd515679e"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ns-darwin-arm64"
        sha256 "8c199ba4b23f178c7840813ec00b196d4271f0d6b9adb2a701973554a0674287"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ctx-darwin-amd64"
      sha256 "0c3546726027aa1bd91ba9e75e67bc8b4d89f6476cf8184d10746bb751cd79e7"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ns-darwin-amd64"
        sha256 "a17f593c5e75468f4ef83b88d000e1b5c93a9c425e1327fa48265c950af786db"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ctx-linux-arm64"
      sha256 "5d8fe8d688b1a649adf505e8db909dba9af909ff2eaa076a52a9bda2c4051276"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ns-linux-arm64"
        sha256 "ff2767a78f0919b0c2f6324042a0da4202f288a46ebfd9522455a011cecc4ddd"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ctx-linux-amd64"
      sha256 "038389c6caba4f6cfcb4b20990f62bdc19a01727e4200f5391b875f860cfad09"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.9/kubectl-ns-linux-amd64"
        sha256 "a9b830d070e78359b2700f764b90b16a2f4509d72b50170e12cce2dbf2fb7d6a"
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
