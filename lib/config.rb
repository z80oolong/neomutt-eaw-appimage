module Config
  module_function

  def stable_version_list
    return %w(20200501 20200619 20200626 20200807 20200814 20200821 20200925 20201120 20201127 20210205 20211015 20211022 20211029 20220408 20220415 20220429)
  end

  def stable_version
    return stable_version_list[-1]
  end

  def devel_version_list
    return []
  end

  def devel_version
    return ""
  end

  def commit_long
    return "5190a58ba4b6d9d65aa8dc93bdf83d760913d2f1"
  end

  def commit
    return commit_long[0..7]
  end

  def commit_sha256
    @@curl ||= %x{which curl}.chomp!
    @@sha256sum ||= %x{which sha256sum}.chomp!
    @@archive_url ||= "https://github.com/neomutt/neomutt/archive"
    @@commit_sha256 ||= %x{#{@@curl} -s -L -o - #{@@archive_url}/#{commit_long}.tar.gz | #{@@sha256sum} -}.chomp.gsub(/^([0-9a-f]*).*/) { $1 }
    return @@commit_sha256
  end

  def head_version
    return "20220901-next"
  end

  def appimage_version
    return "v#{stable_version}-eaw-appimage-0.1.0"
  end

  def appimage_revision
    return 1
  end

  def release_dir
    return "/vagrant/opt/releases"
  end

  def formula_dir
    return "/vagrant/opt/formula"
  end

  def lib_dir
    return "/vagrant/lib"
  end

  def appimage_builder_rb
    return "neomutt-builder.rb"
  end

  def appimage_name
    return "neomutt-eaw"
  end

  def appimage_command
    return "neomutt"
  end

  def appimage_arch
    return "x86_64"
  end

  def formula_tap
    return "z80oolong/eaw"
  end

  def formula_name
    return "neomutt"
  end

  def formula_fullname
    return "#{formula_tap}/#{formula_name}"
  end

  def formula_desc
    return "AppImage package of Free (GNU) replacement for the Pico text editor."
  end

  def formula_homepage
    return "https://neomutt.org/"
  end

  def formula_download_url
    return "https://github.com/z80oolong/neomutt-eaw-appimage/releases/download"
  end
end
