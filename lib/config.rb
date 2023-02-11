module Config
  module_function

  def stable_version?
    return true
  end

  def current_vm_provider
    return "lxc"
    #return "libvirt"
  end

  def current_libvirt_driver
    return "qemu"
    #return "kvm"
  end

  def appimage_tap_name
    return "z80oolong/appimage"
  end

  def current_tap_name
    return "z80oolong/eaw"
  end

  def current_formula_name
    return "neomutt"
  end

  def current_builder_name
    return "neomutt-builder"
  end

  def current_appimage_name
    return "#{current_formula_name}-eaw"
  end

  def current_version_list
    if stable_version? then
      return %w[20200501 20200619 20200626 20200807 20200814 20200821 20200925 20201120 20201127 20210205 20211015 20211022 20211029 20220408 20220415]
    else
      return ["HEAD-#{commit}"]
    end
  end

  def all_stable_version
    return %w[20200501 20200619 20200626 20200807 20200814 20200821 20200925 20201120 20201127 20210205 20211015 20211022 20211029 20220408 20220415 20220429]
  end

  def current_head_formula_version
    return "20240101-next"
  end

  def all_stable_formulae
    return all_stable_version.map do |v|
      "#{Config::current_tap_name}/#{Config::current_formula_name}@#{v}"
    end
  end

  def current_head_formula
    return "#{lib_dir}/#{current_formula_name}@#{current_head_formula_version}.rb"
  end

  def commit_long
    return "e26e9d7ab4cf0dbab6f73466ea9b359d297731c7"
  end

  def commit
    return commit_long[0..7]
  end

  def current_appimage_revision
    return 53
  end

  def release_dir
    return "/vagrant/opt/releases"
  end

  def lib_dir
    return "/vagrant/lib"
  end

  def appimage_arch
    return "x86_64"
  end
end
