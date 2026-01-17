class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.0-alpha5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-arm64"
      sha256 "ee173aaeda697e93d05ae320934c711b2ca5043c6f4a6144b8f52d27c08e5ec3"
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-amd64"
      sha256 "fa9cbcd29cf3ae8d7321a4fc30f257ee045e10dd159fc2236ef742a9953ea913"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-arm64"
      sha256 "4e7057a3dc688dcdcd754d6fad41dca02e40c2dec9c0759d3d41f8de7fe519c5"
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-amd64"
      sha256 "3e39c77f3f8ea39c5f5938ccad4fe0969ef1b650ce497941fb3c443a0bc56f40"
    end
  end

  resource "kubectl-ns-darwin-arm64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha5/kubectl-ns-darwin-arm64"
    sha256 "713d6e8f381971933dd77920ec203d9db0ef4230b7aad04e487bd792f4a1f4a3"
  end

  resource "kubectl-ns-darwin-amd64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha5/kubectl-ns-darwin-amd64"
    sha256 "cf089729cf127608f74cf227ac61231674c5997d050fc08c863e1c11ddf91c80"
  end

  resource "kubectl-ns-linux-arm64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha5/kubectl-ns-linux-arm64"
    sha256 "cfc5e0679fc64520b051f4b37bf67ede3ca71c0d0be06697e390f8f61d40933f"
  end

  resource "kubectl-ns-linux-amd64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha5/kubectl-ns-linux-amd64"
    sha256 "13ce1fdb4cbd2e8db56a5bbfc476666bd4cd5d01472598d94969da95dddfa130"
  end

  def install
    # Determine platform suffix
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    suffix = "#{os}-#{arch}"

    # Install kubectl-ctx (main binary from URL)
    bin.install "kubectl-ctx-#{suffix}" => "kubectl-ctx"

    # Install kubectl-ns (from resource)
    resource("kubectl-ns-#{suffix}").stage do
      bin.install "kubectl-ns-#{suffix}" => "kubectl-ns"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kubectl-ctx --version")
    assert_match version.to_s, shell_output("#{bin}/kubectl-ns --version")
  end
end
