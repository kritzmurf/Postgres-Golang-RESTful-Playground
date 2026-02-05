load_configuration() {
    local include_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
    local config_env="$include_dir/script_config.env"

    # Source Includes
    if [ -f "$config_env" ]; then
        source "$config_env"
    else
        echo "Error: config file not found at $config_env"
        exit 1
    fi

    # Run validation
    for var in "$@"; do
        if [[ -z "${!var}" ]]; then
            echo "Error: '$var' is not defined. Check script_config.env"
            exit 1
        fi
    done
}
