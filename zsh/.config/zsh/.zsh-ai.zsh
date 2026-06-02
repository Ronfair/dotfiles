ait() {
    local model
    local query="$1"

    # Default model
    if [[ -z "$query" ]]; then
        model="dolphin-llama3:8b"
    else
        # Find first matching model from ollama list
        model=$(ollama list | awk 'NR>1 {print $1}' | grep -i "$query" | head -n1)
    fi

    if [[ -z "$model" ]]; then
        echo "No matching model found for: $query"
        echo
        echo "Available models:"
        ollama list
        return 1
    fi

    echo "Launching: $model"
    ollama run "$model"
}

function ai() {
    (
        cd "/mnt/Projects/AI/PrivateGPT/private-gpt" || exit

        case "$1" in
            ingest|i)
                PGPT_PROFILES=ollama make ingest
                ;;

            run|r|"")
                (sleep 3 && xdg-open http://localhost:8001 >/dev/null 2>&1) &
                PGPT_PROFILES=ollama make run
                ;;

            ir|ri)
                PGPT_PROFILES=ollama make ingest || exit
                (sleep 3 && xdg-open http://localhost:8001 >/dev/null 2>&1) &
                PGPT_PROFILES=ollama make run
                ;;

            *)
                echo "Usage: ai [run|r|ingest|i|ir]"
                return 1
                ;;
        esac
    )
}
