#!/bin/bash

# PostToolUse hook that runs make format after file modifications
# Uses the project's Makefile for formatting

# Main execution
main() {
    # Check which tool was used
    if [[ "$TOOL_NAME" == "Edit" || "$TOOL_NAME" == "MultiEdit" || "$TOOL_NAME" == "Write" ]]; then
        # Extract file path if available
        if [[ -n "$TOOL_PARAMS" ]]; then
            local file_path=$(echo "$TOOL_PARAMS" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*:[[:space:]]*"\([^"]*\)".*/\1/')
            if [[ -n "$file_path" ]]; then
                echo "[POST_TOOL_USE] File modified: $file_path" >&2
            fi
        fi
        
        # Check if Makefile exists and has format target
        if [[ -f "Makefile" ]] && make -n format &>/dev/null; then
            echo "[POST_TOOL_USE] Running 'make format'" >&2
            
            # Run make format
            make format
            local exit_code=$?
            
            if [ $exit_code -eq 0 ]; then
                echo "[POST_TOOL_USE] Formatter completed successfully" >&2
            else
                echo "[POST_TOOL_USE] Formatter failed with exit code: $exit_code" >&2
            fi
        else
            echo "[POST_TOOL_USE] No 'make format' target found. Skipping formatting." >&2
        fi
    fi
}

# Run main function
main