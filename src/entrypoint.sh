#!/bin/sh
# ===========================================================================
# mStream entrypoint for a non-root container (TOS 7 requirement).
#
# The LinuxServer image starts mStream through s6 as root, which cannot happen
# inside a container that already runs as uid 1000. This wrapper writes a minimal
# config on the first start and starts the node server directly.
# ===========================================================================
set -e
set -u

CFG=/config
mkdir -p "$CFG" /music 2>/dev/null || true

if ! ( : > "$CFG/.write-test" ) 2>/dev/null; then
  echo "mstream: $CFG is not writable by uid $(id -u)" >&2
  exit 1
fi
rm -f "$CFG/.write-test"

if [ ! -s "$CFG/config.json" ]; then
  cat > "$CFG/config.json" <<'JSON'
{
  "port": 3000,
  "webPort": 3000,
  "musicDir": "/music",
  "storage": {}
}
JSON
  echo "mstream: wrote $CFG/config.json"
fi

exec mstream -j "$CFG/config.json"
