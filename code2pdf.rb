class Code2pdf < Formula
  include Language::Python::Virtualenv

  desc "Print source code to PDF with syntax highlighting, contents and CJK support"
  homepage "https://github.com/readbysearch/code2pdf"
  url "https://github.com/readbysearch/code2pdf/archive/refs/tags/v3.13.tar.gz"
  sha256 "8048b742794817cb142b4b095d15c05520b3277cafc271d88f8f3758524e36a4"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/readbysearch/homebrew-tap/releases/download/code2pdf-3.13"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "103d6083e9d38d2ab4a4c2def5cca0e8293c89e6973e08edfaedaf7260955603"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5a02777b6e5eed5e60c98156102dead1a886804bf763d9ad4919fa37457144e3"
    sha256 cellar: :any,                 x86_64_linux:  "64fc15ff7dccf50305099e41516edba7d3493c52ebab739496d5d06248f4018a"
  end

  depends_on "cffi" => :no_linkage
  depends_on "pango"
  depends_on "pillow"
  depends_on "python@3.14"

  uses_from_macos "libffi"

  # WeasyPrint and its Python dependencies (mirrored from homebrew-core's weasyprint formula; brotli
  # and zopfli are compiled), plus Pygments and pypdf (joins big documents rendered in parts)
  resource "brotli" do
    url "https://files.pythonhosted.org/packages/f7/16/c92ca344d646e71a43b8bb353f0a6490d7f6e06210f8554c8f874e454285/brotli-1.2.0.tar.gz"
    sha256 "e310f77e41941c13340a95976fe66a8a95b01e783d430eeaf7a2f87e0a57dd0a"
  end

  resource "cssselect2" do
    url "https://files.pythonhosted.org/packages/06/00/2456b6b664c7a770989cbe3c352aac4eb962c938486f03a2e1255ae963c6/cssselect2-0.10.1.tar.gz"
    sha256 "83b0d820ef589dabaf693289b647c2f5b410f76d285f56deba911ffa75a7b9d1"
  end

  resource "fonttools" do
    url "https://files.pythonhosted.org/packages/d4/41/0f072a712dc74496e03710e462a18a4cfd8a258ad055a4e22d28b43a7abd/fonttools-4.64.0.tar.gz"
    sha256 "ecb2e59a7bc692fee64dda6010deb66222335693b30046f15cccf81233aa715f"
  end

  resource "pydyf" do
    url "https://files.pythonhosted.org/packages/36/ee/fb410c5c854b6a081a49077912a9765aeffd8e07cbb0663cfda310b01fb4/pydyf-0.12.1.tar.gz"
    sha256 "fbd7e759541ac725c29c506612003de393249b94310ea78ae44cb1d04b220095"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "pypdf" do
    url "https://files.pythonhosted.org/packages/45/7e/d08c72b29e89b1ad14acaae817685ca06bac93691bddfd4fac08a703e5b0/pypdf-6.20.0.tar.gz"
    sha256 "72b1e897fef7f5bbed7f2a93881a4861d98dbf25ae39981c8a023583239edbda"
  end

  resource "pyphen" do
    url "https://files.pythonhosted.org/packages/94/47/8430452269cd28863d73b903d07d329d058cf762527ff211b3864ba61fc7/pyphen-0.18.1.tar.gz"
    sha256 "dbae6fbbe4f01cb206108b43573d857c67107be9d0e38eb1b08d6fa2210634a7"
  end

  resource "tinycss2" do
    url "https://files.pythonhosted.org/packages/a3/ae/2ca4913e5c0f09781d75482874c3a95db9105462a92ddd303c7d285d3df2/tinycss2-1.5.1.tar.gz"
    sha256 "d339d2b616ba90ccce58da8495a78f46e55d4d25f9fd71dfd526f07e7d53f957"
  end

  resource "tinyhtml5" do
    url "https://files.pythonhosted.org/packages/b1/1f/cfe2f6b30557c92b3f31d41707e09cef5c1efbd87392bc6c0430c46b0e4d/tinyhtml5-2.1.0.tar.gz"
    sha256 "60a50ec3d938a37e491efa01af895853060943dcebb5627de5b10d188b338a67"
  end

  resource "weasyprint" do
    url "https://files.pythonhosted.org/packages/8d/0e/461aeb736762862b511034933d5b98d68f812431b7393b026d9ace5f6b42/weasyprint-70.0.tar.gz"
    sha256 "c263abf0e86c747b12af678b67f85f4abbfb97d18a20503031e7ba94e4b8cf8c"
  end

  resource "webencodings" do
    url "https://files.pythonhosted.org/packages/d5/a0/8fd707bcb776a7be556bad06a2ea5fb9bd519df78ef8e26f70ccf0f38bff/webencodings-0.6.1.tar.gz"
    sha256 "565f9ad031c702dae404e27a099e3e09186a3ab1b9520f06d215502b651fd910"
  end

  resource "zopfli" do
    url "https://files.pythonhosted.org/packages/74/21/3b6af43a663b22b00e738bb0642931a2579e15da6852613d56c6aa535d28/zopfli-0.4.3.tar.gz"
    sha256 "d3a50f91a13cea9bafe025de8fd87a005eb26de02a4f0c193127ddbf23ac8ebe"
  end

  def install
    venv = virtualenv_create(libexec, "python3.14")
    venv.pip_install resources

    prefix.install "scripts", "fonts", "VERSION"
    (libexec/"launchers").install "bin/code2pdf", "bin/code2txt"

    # CODE2PDF_HOME points the launchers at this keg; the scripts call plain `python3`,
    # so put the virtualenv (pygments + weasyprint) first on PATH
    env = {
      CODE2PDF_HOME: opt_prefix,
      PATH:          "#{libexec}/bin:$PATH",
    }
    %w[code2pdf code2txt].each do |cmd|
      (bin/cmd).write_env_script libexec/"launchers"/cmd, env
    end
  end

  test do
    (testpath/"hello.py").write <<~PYTHON
      # 你好，世界
      print("Hello, World!")
    PYTHON
    system bin/"code2pdf", "-s", "hello.py"
    assert_path_exists testpath/"hello.pdf"
    assert_match(/^%PDF-/, File.binread(testpath/"hello.pdf", 8))

    assert_match "installed: Homebrew", shell_output("#{bin}/code2pdf --version")

    system bin/"code2txt", "--include-types", "py", "-o", "out.txt", testpath
    assert_match "Hello, World!", (testpath/"out.txt").read

    # Force parts mode so the pypdf join is exercised
    (testpath/"big").mkpath
    3.times { |i| (testpath/"big/m#{i}.py").write("x = 1\n" * 80) }
    with_env(CODE2PDF_PART_PAGES: "1", CODE2PDF_JOBS: "2") do
      system bin/"code2pdf", "-a", testpath/"big"
    end
    assert_match(/^%PDF-/, File.binread(testpath/"big/merged.pdf", 8))
  end
end
