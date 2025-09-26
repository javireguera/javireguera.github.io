#!/bin/bash
set -e
cd /web

# If no hugo.yaml, clone Hugobricks
if [ ! -f hugo.yaml ] && [ ! -f config.yaml ] && [ ! -f hugo.toml ] && [ ! -f config.toml ]; then
    echo "Cloning Hugobricks..."
    git clone --depth=1 "$HUGOBRICKS_REPO" /tmp/hugobricks
    cd /tmp/hugobricks
    tar --exclude='.git' -cf - . | (cd /web && tar -xf -)
    cd /web
    rm -rf /tmp/hugobricks
    echo "Hugobricks setup completed."
fi

if [ ! -d themes/hugobricks ]; then
    echo "Cloning Hugobricks theme..."
    git clone --depth=1 "$HUGOBRICKS_REPO" /tmp/hugobricks
    rsync -av --ignore-existing /tmp/hugobricks/ /web/
    rm -rf /tmp/hugobricks
    echo "Hugobricks theme setup completed."
fi

# Clean previous builds
rm -rf /web/.hugo_build.lock /web/resources 2>/dev/null || true

# Execute whatever command was passed (from docker-compose command override)
exec "$@"