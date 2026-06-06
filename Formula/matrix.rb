# Homebrew formula for the Matrix OS CLI.
#
# Lives here for version control during bootstrap; the CI release workflow
# mirrors it into the FinnaAI/homebrew-tap repository and bumps url/sha256
# on each tag push.
#
# Install: brew install finnaai/tap/matrix

class Matrix < Formula
  desc "Matrix OS command-line client (sync, login, peer management)"
  homepage "https://matrix-os.com"

  # `url` and `sha256` are rewritten by .github/workflows/release.yml against
  # the npm tarball after each publish. Until the first release job rewrites
  # this staging copy, the placeholder sha256 is intentionally non-installable.
  url "https://registry.npmjs.org/@finnaai/matrix/-/matrix-0.3.4.tgz"
  sha256 "015c17b2e9dfb00ec8a20bf1dd98c48e0510b6fab4a8c4d276cece8f4ca960ef"
  version "0.3.4"

  license "AGPL-3.0-or-later"

  depends_on "node@24"

  def install
    # Install the package into libexec, then symlink the bins into HOMEBREW_PREFIX/bin.
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # `matrix --version` exits with the version from package.json.
    output = shell_output("#{bin}/matrix --version")
    assert_match version.to_s, output
  end
end
