function expose --description 'Expose a local port publicly via SSH tunnel (ngrok alternative)'
    # Parse arguments
    set -l port 3000
    set -l host localhost

    # Check for port argument
    if test (count $argv) -ge 1
        set port $argv[1]
    end

    # Check for host argument (for exposing services on other local machines)
    if test (count $argv) -ge 2
        set host $argv[2]
    end

    # Validate port is a number
    if not string match -qr '^\d+$' -- $port
        echo "Error: Port must be a number" >&2
        return 1
    end

    # Display info
    echo "🌐 Exposing $host:$port to the internet..."
    echo "📡 Connecting via pinggy.io..."
    echo ""

    # Run the SSH tunnel
    # The -R0 means the remote server assigns a random port
    # Output will show the public URL
    ssh -p 443 -R0:$host:$port a.pinggy.io
end
