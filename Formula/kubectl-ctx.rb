class KubectlCtx < Formula
  desc "Kubernetes context and namespace switchers using client-go libraries"
  homepage "https://github.com/camaeel/kubectl-ctx"
  version "0.1.0-alpha2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-arm64"
      sha256 "cb12423b7156a9b16d2a69859b6623ad089aaad482af6f8fda948382ae58ebed"
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-darwin-amd64"
      sha256 "5ab0fe228d9c3f8f46892dad51efe9b6ebfcf5f564c5f0c98d33ffbefb743e76"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-arm64"
      sha256 "eb2195bd331e352c9d61e683782ef533ffb120af9e7042f27b00af267d350319"
    else
      url "https://github.com/camaeel/kubectl-ctx/releases/download/v#{version}/kubectl-ctx-linux-amd64"
      sha256 "2a601c3eb79ceeec761219894fc8f847b7d8f72115ec1cb0d614be068a3b6a06"
    end
  end

  resource "kubectl-ns-darwin-arm64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha2/kubectl-ns-darwin-arm64"
    sha256 "ee288177c5e07ea1d34a123a602a027a31fd931abba2ea9324452bf19fb182aa"
  end

  resource "kubectl-ns-darwin-amd64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha2/kubectl-ns-darwin-amd64"
    sha256 "165f4c6a09f2d7926078b54be87eca165aa9bc7ddb6a243ba909bab908110c42"
  end

  resource "kubectl-ns-linux-arm64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha2/kubectl-ns-linux-arm64"
    sha256 "a86ea1f603effd5f7d5fe757a88e564bf26207b5b2750496de423c13a4bcb6ab"
  end

  resource "kubectl-ns-linux-amd64" do
    url "https://github.com/camaeel/kubectl-ctx/releases/download/v0.1.0-alpha2/kubectl-ns-linux-amd64"
    sha256 "f9af4d22cbca38d8ea94d8e4414bf42714752ca0e72911b4cace25b0b89df6a5"
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
