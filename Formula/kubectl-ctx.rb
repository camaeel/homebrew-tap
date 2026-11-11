class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ctx-darwin-arm64"
      sha256 "2db83bce3a0e88dc44765f1f9b12dd3b86556742d4c7d6a50ae9614c91fb9771"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ns-darwin-arm64"
        sha256 "839312cf74286bef37abcdcb9f45c8e04dd9cd1f47904fdebf25404138404d9c"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ctx-darwin-amd64"
      sha256 "2499798cdf0bc934f774e9cdffd1bbb568a708d87117b9eae064a3b713e9e753"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ns-darwin-amd64"
        sha256 "1515ca84736770f882853068d9ca18377b95bab21025441efc2d765c05da854b"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ctx-linux-arm64"
      sha256 "ba255559c73710fecca73cd1a309e5c62b914230db817f6793897cbb48075c4a"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ns-linux-arm64"
        sha256 "0810d13a14982aeb9e2bc17b7529e5d91dcec61eef399e5b0147f79f86fcd633"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ctx-linux-amd64"
      sha256 "4c1e96beb4e269b08015f243860acb77ffe8e91f7dcd38d2d4b44ac41847f70f"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.15/kubectl-ns-linux-amd64"
        sha256 "a0a6fb92ab6aa3b38462c6ed6099f8b1a6f28956332ffb9a549e557e3e7254a7"
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
