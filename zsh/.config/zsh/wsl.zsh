# WSL related settings
# Only take effect in WSL2.

# system checker
is_wsl2() {
  grep -qi 'WSL2' /proc/sys/kernel/osrelease 2>/dev/null \
  || grep -qi 'WSL2' /proc/version 2>/dev/null
}

if is_wsl2; then

# Proxy helpers (WSL ↔ Windows SOCKS5).
# Scripts below only work when WSL networking mode is set to mirrored.
# Forward traffic through host-side proxy at 127.0.0.1:10090.
PROXY_ADDR="127.0.0.1"
PROXY_PORT="10090"
PROXY_URL="socks5h://${PROXY_ADDR}:${PROXY_PORT}"

proxy_on() {
  export http_proxy=$PROXY_URL
  export https_proxy=$PROXY_URL
  export ftp_proxy=$PROXY_URL
  export ALL_PROXY=$PROXY_URL
  export no_proxy="localhost,127.0.0.1,::1"
  echo "🌐  Proxy enabled → $PROXY_URL"
}

proxy_off() {
  unset http_proxy https_proxy ftp_proxy ALL_PROXY no_proxy
  echo "🚧  Proxy disabled"
}

# default turned on
proxy_on

fi
