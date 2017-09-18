package=zeromq
$(package)_version=4.2.2-1
$(package)_download_path=https://github.com/ca333/libzmq/archive/
$(package)_download_file=v$($(package)_version).tar.gz
$(package)_file_name=libzmq-$($(package)_version).tar.gz
$(package)_sha256_hash=0e225b85ce11be23bf7eb7d3f25c6686728bf30d5c31f61c12d37bb646c69962

define $(package)_set_vars
  $(package)_build_env+=
  $(package)_config_opts=--enable-shared=false --enable-static --host=x86_64-w64-mingw32
  $(package)_config_opts_mingw32=--enable-shared=false --enable-static --host=x86_64-w64-mingw32
  $(package)_cflags=-Wno-error -Wall -Wno-pedantic-ms-format -DLIBCZMQ_EXPORTS -DZMQ_DEFINED_STDINT -lws2_32 -liphlpapi -lrpcrt4
  $(package)_conf_tool=./configure
endef

define $(package)_preprocess_cmds
  cd $($(package)_build_subdir); ./autogen.sh
endef

define $(package)_config_cmds
  $($(package)_conf_tool) $($(package)_config_opts) CFLAGS="-Wno-error -Wall -Wno-pedantic-ms-format -DLIBCZMQ_EXPORTS -DZMQ_DEFINED_STDINT -lws2_32 -liphlpapi -lrpcrt4"
endef

define $(package)_build_cmds
  $(MAKE) src/libzmq.la
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install-libLTLIBRARIES install-includeHEADERS install-pkgconfigDATA
endef

define $(package)_postprocess_cmds
  rm -rf bin share
endef
