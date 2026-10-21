class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ctx-darwin-arm64"
      sha256 "9aa95c5618312c064383d59e6212274e15b37112da28f6f7a0c4520535c14a16"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ns-darwin-arm64"
        sha256 "4707399bf10fbae84126d4d7a83a3ed7f69c0e767b9e09bc52f102b4378505de"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ctx-darwin-amd64"
      sha256 "36d8a0df4b6a92b0e4e50dc51631ebfca5682c255f217c23b7dbc3a00952efe5"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ns-darwin-amd64"
        sha256 "66e3a9655c8659843f8ba7890cfcfde1507eb235c30f940c8af60a21db563a7f"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ctx-linux-arm64"
      sha256 "bad896054712ad4e96f4de30f3f6e5b854cd9114fbe7497bfec438105b0ce84e"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ns-linux-arm64"
        sha256 "ef7b0d8e02992639f353bf99ffeea4745cfca3a2ff7c9fe832dfbf9f64d5ff2b"
      end
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ctx-linux-amd64"
      sha256 "211f9d9ec01d5719d9cd6e93be08266396abf6a5792678a187782e3725f2dcda"

      resource "kubectl-ns" do
        url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.14/kubectl-ns-linux-amd64"
        sha256 "e6ef3ba83ab791e1396faa87b2c0967355011e89f0b9d15798e97417c0bafb57"
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
