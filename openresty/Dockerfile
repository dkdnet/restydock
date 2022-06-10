# Dockerfile - Ubuntu Bionic
# https://github.com/openresty/docker-openresty

ARG RESTY_IMAGE_BASE="ubuntu"
ARG RESTY_IMAGE_TAG="bionic"

FROM ${RESTY_IMAGE_BASE}:${RESTY_IMAGE_TAG}

LABEL maintainer="Evan Wies <evan@neomantra.net>"

# Docker Build Arguments
ARG RESTY_IMAGE_BASE="ubuntu"
ARG RESTY_IMAGE_TAG="bionic"
ARG RESTY_VERSION="1.21.4.1"
ARG RESTY_LUAROCKS_VERSION="3.9.0"
ARG RESTY_OPENSSL_VERSION="1.1.1n"
ARG RESTY_OPENSSL_PATCH_VERSION="1.1.1f"
ARG RESTY_OPENSSL_URL_BASE="https://www.openssl.org/source"
ARG RESTY_PCRE_VERSION="8.45"
ARG RESTY_PCRE_SHA256="4e6ce03e0336e8b4a3d6c2b70b1c5e18590a5673a98186da90d4f33c23defc09"
ARG RESTY_J="1"
ARG RESTY_CONFIG_OPTIONS="\
  --with-compat \
  --with-file-aio \
  --with-http_addition_module \
  --with-http_auth_request_module \
  --with-http_dav_module \
  --with-http_flv_module \
  --with-http_geoip_module=dynamic \
  --with-http_gunzip_module \
  --with-http_gzip_static_module \
  --with-http_image_filter_module=dynamic \
  --with-http_mp4_module \
  --with-http_random_index_module \
  --with-http_realip_module \
  --with-http_secure_link_module \
  --with-http_slice_module \
  --with-http_ssl_module \
  --with-http_stub_status_module \
  --with-http_sub_module \
  --with-http_v2_module \
  --with-http_xslt_module=dynamic \
  --with-ipv6 \
  --with-mail \
  --with-mail_ssl_module \
  --with-md5-asm \
  --with-pcre-jit \
  --with-sha1-asm \
  --with-stream \
  --with-stream_ssl_module \
  --with-threads \
  "
ARG RESTY_CONFIG_OPTIONS_MORE="--with-http_postgres_module"
ARG RESTY_LUAJIT_OPTIONS="--with-luajit-xcflags='-DLUAJIT_NUMMODE=2 -DLUAJIT_ENABLE_LUA52COMPAT'"

ARG RESTY_ADD_PACKAGE_BUILDDEPS=""
ARG RESTY_ADD_PACKAGE_RUNDEPS=""
ARG RESTY_EVAL_PRE_CONFIGURE=""
ARG RESTY_EVAL_POST_MAKE=""

# These are not intended to be user-specified
ARG _RESTY_CONFIG_DEPS="--with-pcre \
  --with-cc-opt='-DNGX_LUA_ABORT_AT_PANIC -I/usr/local/openresty/pcre/include -I/usr/local/openresty/openssl/include' \
  --with-ld-opt='-L/usr/local/openresty/pcre/lib -L/usr/local/openresty/openssl/lib -Wl,-rpath,/usr/local/openresty/pcre/lib:/usr/local/openresty/openssl/lib' \
  "

LABEL resty_image_base="${RESTY_IMAGE_BASE}"
LABEL resty_image_tag="${RESTY_IMAGE_TAG}"
LABEL resty_version="${RESTY_VERSION}"
LABEL resty_luarocks_version="${RESTY_LUAROCKS_VERSION}"
LABEL resty_openssl_version="${RESTY_OPENSSL_VERSION}"
LABEL resty_openssl_patch_version="${RESTY_OPENSSL_PATCH_VERSION}"
LABEL resty_openssl_url_base="${RESTY_OPENSSL_URL_BASE}"
LABEL resty_pcre_version="${RESTY_PCRE_VERSION}"
LABEL resty_pcre_sha256="${RESTY_PCRE_SHA256}"
LABEL resty_config_options="${RESTY_CONFIG_OPTIONS}"
LABEL resty_config_options_more="${RESTY_CONFIG_OPTIONS_MORE}"
LABEL resty_config_deps="${_RESTY_CONFIG_DEPS}"
LABEL resty_add_package_builddeps="${RESTY_ADD_PACKAGE_BUILDDEPS}"
LABEL resty_add_package_rundeps="${RESTY_ADD_PACKAGE_RUNDEPS}"
LABEL resty_eval_pre_configure="${RESTY_EVAL_PRE_CONFIGURE}"
LABEL resty_eval_post_make="${RESTY_EVAL_POST_MAKE}"

ARG DEBIAN_FRONTEND=noninteractive
# RUN sed -i s@/ports.ubuntu.com/@/mirrors.163.com/@g /etc/apt/sources.list
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.163.com/@g /etc/apt/sources.list

###########################################################################
# Mongo: lua-resty-mongol
###########################################################################
# 安装moggodb驱动依赖 RUN apt install libbson-1.0-0 -y
ARG CHANGE_SOURCE=false
RUN if [ ${CHANGE_SOURCE} = true ]; then \
  RUN sed -i s@/ports.ubuntu.com/@/mirrors.163.com/@g /etc/apt/sources.list && \
  RUN sed -i s@/archive.ubuntu.com/@/mirrors.163.com/@g /etc/apt/sources.list && \
  RUN export node_mirror=https://npm.taobao.org/mirrors/node/ && \
  RUN export npm_mirror=https://npm.taobao.org/mirrors/npm/ \
  ;fi

RUN apt-get clean
RUN apt-get update
# RUN apt-get install dialog
RUN apt-get install tzdata libpq-dev -y


RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  gettext-base \
  libgd-dev \
  libgeoip-dev \
  libncurses5-dev \
  libperl-dev \
  libreadline-dev \
  libxslt1-dev \
  make \
  perl \
  unzip \
  wget \
  zlib1g-dev \
  ${RESTY_ADD_PACKAGE_BUILDDEPS} \
  ${RESTY_ADD_PACKAGE_RUNDEPS} \
  && cd /tmp \
  && if [ -n "${RESTY_EVAL_PRE_CONFIGURE}" ]; then eval $(echo ${RESTY_EVAL_PRE_CONFIGURE}); fi \
  && curl -fSL "${RESTY_OPENSSL_URL_BASE}/openssl-${RESTY_OPENSSL_VERSION}.tar.gz" -o openssl-${RESTY_OPENSSL_VERSION}.tar.gz \
  && tar xzf openssl-${RESTY_OPENSSL_VERSION}.tar.gz \
  && cd openssl-${RESTY_OPENSSL_VERSION} \
  && if [ $(echo ${RESTY_OPENSSL_VERSION} | cut -c 1-5) = "1.1.1" ] ; then \
  echo 'patching OpenSSL 1.1.1 for OpenResty' \
  && curl -s https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-${RESTY_OPENSSL_PATCH_VERSION}-sess_set_get_cb_yield.patch | patch -p1 ; \
  fi \
  && if [ $(echo ${RESTY_OPENSSL_VERSION} | cut -c 1-5) = "1.1.0" ] ; then \
  echo 'patching OpenSSL 1.1.0 for OpenResty' \
  && curl -s https://raw.githubusercontent.com/openresty/openresty/ed328977028c3ec3033bc25873ee360056e247cd/patches/openssl-1.1.0j-parallel_build_fix.patch | patch -p1 \
  && curl -s https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-${RESTY_OPENSSL_PATCH_VERSION}-sess_set_get_cb_yield.patch | patch -p1 ; \
  fi \
  && ./config \
  no-threads shared zlib -g \
  enable-ssl3 enable-ssl3-method \
  --prefix=/usr/local/openresty/openssl \
  --libdir=lib \
  -Wl,-rpath,/usr/local/openresty/openssl/lib \
  && make -j${RESTY_J} \
  && make -j${RESTY_J} install_sw \
  && cd /tmp \
  && curl -fSL https://downloads.sourceforge.net/project/pcre/pcre/${RESTY_PCRE_VERSION}/pcre-${RESTY_PCRE_VERSION}.tar.gz -o pcre-${RESTY_PCRE_VERSION}.tar.gz \
  && echo "${RESTY_PCRE_SHA256}  pcre-${RESTY_PCRE_VERSION}.tar.gz" | shasum -a 256 --check \
  && tar xzf pcre-${RESTY_PCRE_VERSION}.tar.gz \
  && cd /tmp/pcre-${RESTY_PCRE_VERSION} \
  && ./configure \
  --prefix=/usr/local/openresty/pcre \
  --disable-cpp \
  --enable-jit \
  --enable-utf \
  --enable-unicode-properties \
  && make -j${RESTY_J} \
  && make -j${RESTY_J} install \
  && cd /tmp \
  && curl -fSL https://openresty.org/download/openresty-${RESTY_VERSION}.tar.gz -o openresty-${RESTY_VERSION}.tar.gz \
  && tar xzf openresty-${RESTY_VERSION}.tar.gz \
  && cd /tmp/openresty-${RESTY_VERSION} \
  && eval ./configure -j${RESTY_J} ${_RESTY_CONFIG_DEPS} ${RESTY_CONFIG_OPTIONS} ${RESTY_CONFIG_OPTIONS_MORE} ${RESTY_LUAJIT_OPTIONS} \
  && make -j${RESTY_J} \
  && make -j${RESTY_J} install \
  && cd /tmp \
  && rm -rf \
  openssl-${RESTY_OPENSSL_VERSION}.tar.gz openssl-${RESTY_OPENSSL_VERSION} \
  pcre-${RESTY_PCRE_VERSION}.tar.gz pcre-${RESTY_PCRE_VERSION} \
  openresty-${RESTY_VERSION}.tar.gz openresty-${RESTY_VERSION} \
  && curl -fSL https://luarocks.github.io/luarocks/releases/luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz -o luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
  && tar xzf luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
  && cd luarocks-${RESTY_LUAROCKS_VERSION} \
  && ./configure \
  --prefix=/usr/local/openresty/luajit \
  --with-lua=/usr/local/openresty/luajit \
  --lua-suffix=jit-2.1.0-beta3 \
  --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 \
  && make build \
  && make install \
  && cd /tmp \
  && if [ -n "${RESTY_EVAL_POST_MAKE}" ]; then eval $(echo ${RESTY_EVAL_POST_MAKE}); fi \
  && rm -rf luarocks-${RESTY_LUAROCKS_VERSION} luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
  && if [ -n "${RESTY_ADD_PACKAGE_BUILDDEPS}" ]; then DEBIAN_FRONTEND=noninteractive apt-get remove -y --purge ${RESTY_ADD_PACKAGE_BUILDDEPS} ; fi \
  && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y \
  && mkdir -p /var/run/openresty \
  && ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
  && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

# Add additional binaries into PATH for convenience
ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

# Add LuaRocks paths
# If OpenResty changes, these may need updating:
#    /usr/local/openresty/bin/resty -e 'print(package.path)'
#    /usr/local/openresty/bin/resty -e 'print(package.cpath)'
ENV LUA_PATH="/usr/local/openresty/site/lualib/?.ljbc;/usr/local/openresty/site/lualib/?/init.ljbc;/usr/local/openresty/lualib/?.ljbc;/usr/local/openresty/lualib/?/init.ljbc;/usr/local/openresty/site/lualib/?.lua;/usr/local/openresty/site/lualib/?/init.lua;/usr/local/openresty/lualib/?.lua;/usr/local/openresty/lualib/?/init.lua;./?.lua;/usr/local/openresty/luajit/share/luajit-2.1.0-beta3/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/openresty/luajit/share/lua/5.1/?.lua;/usr/local/openresty/luajit/share/lua/5.1/?/init.lua"

ENV LUA_CPATH="/usr/local/openresty/site/lualib/?.so;/usr/local/openresty/lualib/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/openresty/luajit/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/local/openresty/luajit/lib/lua/5.1/?.so"

# Copy nginx configuration files
# COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
# COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

# CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]

# 安装moggodb驱动依赖
RUN apt install libbson-1.0-0 -y

###########################################################################
# Install the lua-resty-auto-ssl extension 此模块最好国外安装
###########################################################################
ARG INSTALL_SSL=false

RUN if [ ${INSTALL_SSL} = true ]; then \
  mkdir -p /usr/local/openresty/ssl && \
  mkdir -p /usr/local/openresty/ssl/resty-auto-ssl && \
  chown nobody /usr/local/openresty/ssl/resty-auto-ssl && \
  chgrp nogroup /usr/local/openresty/ssl/resty-auto-ssl && \
  openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
  -subj '/CN=sni-support-required-for-valid-ssl' \
  -keyout /usr/local/openresty/ssl/resty-auto-ssl-fallback.key \
  -out /usr/local/openresty/ssl/resty-auto-ssl-fallback.crt && \
  luarocks install lua-resty-auto-ssl && \
  ln -s /usr/local/openresty/openssl/include/openssl/ /include \
  ;fi


###########################################################################
# Install the lua-resty-moongoo extension
###########################################################################

ARG INSTALL_MONGO_MOOGOO=false

# install detpendents
RUN if [ ${INSTALL_MONGO_MOOGOO} = true ]; then \
  # Install the dependents
  mkdir /temp && \
  cd /temp &&\
  apt install git aptitude -y && \
  aptitude install autoconf automake libtool -y \
  ;fi


RUN if [ ${INSTALL_MONGO_MOOGOO} = true ]; then \
  # Install the lua-resty-moongoo extension
  cd /temp && \
  git clone https://github.com/isage/lua-resty-moongoo.git && \
  cd lua-resty-moongoo && \
  cp -r lib/resty/moongoo /usr/local/openresty/lualib/resty && \
  cp lib/resty/moongoo.lua /usr/local/openresty/lualib/resty \
  ;fi


RUN if [ ${INSTALL_MONGO_MOOGOO} = true ]; then \
  # Install the libbson dependents latest
  cd /temp && \
  git clone -b 1.7.0 https://github.com/mongodb/libbson.git && \
  cd libbson && ./autogen.sh && make && make install && \
  make clean && make LUA_INCLUDE_DIR=/usr/local/openresty/luajit/include/luajit-2.1 LUA_CMODULE_DIR=/usr/local/openresty/lualib LUA_MODULE_DIR=/usr/local/openresty/lualib CBSON_CFLAGS="-g -fpic -I/usr/local/include/libbson-1.0/ " CC=cc \
  ;fi

RUN if [ ${INSTALL_MONGO_MOOGOO} = true ]; then \
  # Install the lua-cbson dependents
  aptitude install cmake -y && \
  cd /temp && \
  git clone https://github.com/isage/lua-cbson.git && \
  cd lua-cbson && \
  mkdir build && \
  cd build && \
  cmake .. && \
  make  && \
  make install \
  ;fi


###########################################################################
# Mongo: lua-resty-mongol
###########################################################################
# 安装moggodb驱动依赖 RUN apt install libbson-1.0-0 -y
ARG INSTALL_MONGO_MONGOL=false
RUN if [ ${INSTALL_MONGO_MONGOL} = true ]; then \
  # Install the lua-cbson dependents
  cd /temp && \
  git clone https://github.com/bigplum/lua-resty-mongol.git && \
  cd ua-resty-mongol && \
  make install \
  ;fi

###########################################################################
# Install the pgmoon extension
###########################################################################
ARG INSTALL_POSTGRES=false
RUN if [ ${INSTALL_POSTGRES} = true ]; then \
  bash -c "cd /temp && \
  luarocks install lua-resty-openssl && \
  luarocks install pgmoon" \
  ;fi

###########################################################################
# Install: lor framework
###########################################################################
COPY lor /lor
WORKDIR /lor
RUN make install
WORKDIR /code

###########################################################################
# Install: nvm
###########################################################################
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# 添加nvm国内源





###########################################################################
# Use SIGQUIT instead of default SIGTERM to cleanly drain requests
# See https://github.com/openresty/docker-openresty/blob/master/README.md#tips--pitfalls
STOPSIGNAL SIGQUIT
