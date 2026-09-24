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
  url "https://registry.npmjs.org/@finnaai/matrix/-/matrix-0.3.19.tgz"
  sha256 "2428f4c2493e282eef0b97db8fd3bd3989379a1da4dc315b24b28cdc998d981a"
  version "0.3.19"

  license "AGPL-3.0-or-later"

  depends_on "node@20"

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
