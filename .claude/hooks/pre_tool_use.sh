#!/bin/bash

# PreToolUse hook for security checks
# Blocks dangerous commands and sensitive file access

# Function to check if command contains dangerous rm patterns
is_dangerous_rm_command() {
    local command="$1"
    local normalized=$(echo "$command" | tr '[:upper:]' '[:lower:]' | tr -s ' ')
    
    # Dangerous rm patterns
    local patterns=(
        '\brm[[:space:]]+.*-[a-z]*r[a-z]*f'          # rm -rf, rm -fr, rm -Rf, etc.
        '\brm[[:space:]]+.*-[a-z]*f[a-z]*r'          # rm -fr variations
        '\brm[[:space:]]+--recursive[[:space:]]+--force'
        '\brm[[:space:]]+--force[[:space:]]+--recursive'
        '\brm[[:space:]]+-r[[:space:]]+.*-f'
        '\brm[[:space:]]+-f[[:space:]]+.*-r'
    )
    
    # Check each pattern
    for pattern in "${patterns[@]}"; do
        if echo "$normalized" | grep -qE "$pattern"; then
            return 0  # Dangerous pattern found
        fi
    done
    
    # Check for rm with recursive flag targeting dangerous paths
    if echo "$normalized" | grep -qE '\brm[[:space:]]+.*-[a-z]*r'; then
        local dangerous_paths=(
            '/'              # Root directory
            '/\*'            # Root with wildcard
            '~'              # Home directory
            '~/'             # Home directory path
            '\$HOME'         # Home environment variable
            '\.\.'           # Parent directory references
            '\*'             # Wildcards
            '\.$'            # Current directory at end
            '\.[[:space:]]'  # Current directory with space
        )
        
        for path_pattern in "${dangerous_paths[@]}"; do
            if echo "$normalized" | grep -qE "$path_pattern"; then
                return 0  # Dangerous pattern found
            fi
        done
    fi
    
    return 1  # No dangerous pattern found
}

# Function to check if accessing sensitive files
is_sensitive_file_access() {
    local tool_name="$1"
    local file_path=""
    local command=""
    
    # Extract file_path or command from JSON input
    if [[ "$tool_name" =~ ^(Read|Edit|MultiEdit|Write)$ ]]; then
        file_path=$(echo "$TOOL_INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*:[[:space:]]*"\([^"]*\)".*/\1/')
        
        # Check for sensitive files (customize this list based on your needs)
        if [[ "$file_path" =~ \.env($|/) ]] && [[ ! "$file_path" =~ \.env\.(sample|example|template) ]]; then
            return 0  # Accessing .env file
        fi
        if [[ "$file_path" =~ \.envrc($|/) ]]; then
            return 0  # Accessing .envrc file
        fi
        # Add more sensitive file patterns as needed
        
    elif [[ "$tool_name" == "Bash" ]]; then
        command=$(echo "$TOOL_INPUT" | grep -o '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*:[[:space:]]*"\([^"]*\)".*/\1/')
        
        # Check for commands accessing sensitive files
        if echo "$command" | grep -qE '\.env($|[[:space:]]|/)' && ! echo "$command" | grep -qE '\.env\.(sample|example|template)'; then
            return 0  # Accessing .env file
        fi
        if echo "$command" | grep -qE '\.envrc($|[[:space:]]|/)'; then
            return 0  # Accessing .envrc file
        fi
    fi
    
    return 1  # Not accessing sensitive files
}

# Main execution
main() {
    # Read JSON input from stdin
    local input_json=$(cat)
    
    # Export for use in functions - handle multi-line JSON
    export TOOL_NAME=$(echo "$input_json" | tr '\n' ' ' | grep -o '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*:[[:space:]]*"\([^"]*\)".*/\1/')
    export TOOL_INPUT=$(echo "$input_json" | tr '\n' ' ' | sed -n 's/.*"tool_input"[[:space:]]*:[[:space:]]*\({[^}]*}\).*/\1/p')
    
    # Check for sensitive file access
    if is_sensitive_file_access "$TOOL_NAME"; then
        echo "BLOCKED: Access to sensitive configuration files is prohibited" >&2
        echo "Use .env.sample, .env.example, or .env.template for template files instead" >&2
        exit 2  # Exit code 2 blocks tool call
    fi
    
    # Check for dangerous rm commands
    if [[ "$TOOL_NAME" == "Bash" ]]; then
        local command=$(echo "$TOOL_INPUT" | grep -o '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*:[[:space:]]*"\([^"]*\)".*/\1/')
        
        if is_dangerous_rm_command "$command"; then
            echo "BLOCKED: Dangerous rm command detected and prevented" >&2
            exit 2  # Exit code 2 blocks tool call
        fi
    fi
    
    # Allow the tool to proceed
    exit 0
}

# Run main function
main