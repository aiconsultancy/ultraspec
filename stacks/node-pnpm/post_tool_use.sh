#!/bin/bash

# PostToolUse hook for Node.js + pnpm projects
# Simply delegates to the Makefile

# Main execution
main() {
    # Check which tool was used
    if [[ "$TOOL_NAME" == "Edit" || "$TOOL_NAME" == "MultiEdit" || "$TOOL_NAME" == "Write" ]]; then
        # Check if Makefile exists and has format target
        if [[ -f "Makefile" ]] && make -n format &>/dev/null; then
            echo "[POST_TOOL_USE] Running 'make format'" >&2
            make format
        fi
    fi
}

# Run main function
main