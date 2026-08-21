# Dependecies:
# npm install -g streaker
# curl

set -euo pipefail

# ----- config -----
export PATH="/data/data/com.termux/files/usr/bin:$PATH"
USERNAME="HasanAgitUnal"
CACHE_DIR="${HOME}/.cache/github-widget"
CACHE_FILE="${CACHE_DIR}/cache.txt"
TIMEOUT=2 # connection check

# ----- checks -----
echo "I: creating cache dir" >&2
mkdir -p "$CACHE_DIR"

check_internet() {
        echo "I: checking internet connection" >&2
        if command -v curl &>/dev/null; then
                curl -s --head --max-time "$TIMEOUT" https://github.com >/dev/null
                return $?
        else
                echo "E: curl not found" >&2
                exit 1
        fi
}

# ----- Main Job -----
if check_internet; then
        echo "I: generating graph" >&2
        node $(which streaker) "$USERNAME" --graph | tee "$CACHE_FILE"
else
        echo "W: no internet, using cache file" >&2
        if [[ -f "$CACHE_FILE" ]]; then
                cat "$CACHE_FILE"
        else
                echo "E: Run with a internet connection at first run" >&2
                exit 1
        fi
fi
