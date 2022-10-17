$:.unshift((Pathname.new(__FILE__).dirname/"..").realpath.to_s)

require "lib/config"

class NeomuttAT20220901Next < Formula
  desc "E-mail reader with support for Notmuch, NNTP and much more"
  homepage "https://neomutt.org/"
  license "GPL-2.0-or-later"

  stable do
    neomutt_version = "HEAD-#{Config::commit}"
    url "https://github.com/neomutt/neomutt/archive/#{Config::commit}.tar.gz"
    sha256 Config::commit_sha256
    version neomutt_version

    patch :p1, Formula["z80oolong/eaw/neomutt"].diff_data
  end

  depends_on "gettext"
  depends_on "gpgme"
  depends_on "libidn"
  depends_on "lmdb"
  depends_on "lua"
  depends_on "notmuch"
  depends_on "openssl@1.1"
  depends_on "tokyo-cabinet"
  depends_on "z80oolong/eaw/ncurses-eaw@6.2"
  unless OS.mac?
    depends_on "krb5"
    depends_on "cyrus-sasl"
    depends_on "patchelf" => :build
  end

  def install
    ENV.append "CFLAGS",   "-I#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_include}"
    ENV.append "CPPFLAGS", "-I#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_include}"
    ENV.append "LDFLAGS",  "-L#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_lib}"
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    system "./configure", "--prefix=#{prefix}",
                          "--enable-gpgme",
                          "--with-gpgme=#{Formula["gpgme"].opt_prefix}",
                          "--disable-doc",
                          "--gss",
                          "--lmdb",
                          "--notmuch",
                          "--sasl",
                          "--tokyocabinet",
                          "--with-ssl=#{Formula["openssl@1.1"].opt_prefix}",
                          "--with-ui=ncurses",
                          "--with-ncurses=#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_prefix}",
                          "--lua",
                          "--with-lua=#{Formula["lua"].prefix}"
    system "make", "install"

    fix_rpath "#{bin}/neomutt", ["z80oolong/eaw/ncurses-eaw@6.2"], ["ncurses"]
  end

  def fix_rpath(binname, append_list, delete_list)
    return unless OS.linux?

    delete_list_hash = {}
    rpath = %x{#{Formula["patchelf"].opt_bin}/patchelf --print-rpath #{binname}}.chomp.split(":")

    (append_list + delete_list).each {|name| delete_list_hash["#{Formula[name].opt_lib}"] = true}
    rpath.delete_if {|path| delete_list_hash[path]}
    append_list.each {|name| rpath.unshift("#{Formula[name].opt_lib}")}

    system "#{Formula["patchelf"].opt_bin}/patchelf", "--set-rpath", "#{rpath.join(":")}", "#{binname}"
  end

  test do
    system "#{bin}/neomutt", "--version"
  end
end
