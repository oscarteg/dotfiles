# DNS switching functions for macOS
# Usage: dns [cloudflare|google|quad9|auto|show|list]

# Get the primary active network service
function dns-get-service
    # Get the active interface device (e.g., en0, en8)
    set active_device (route -n get default 2>/dev/null | grep 'interface:' | awk '{print $2}')

    if test -z "$active_device"
        echo "Wi-Fi"
        return
    end

    # Find the network service name for this device
    set service (networksetup -listnetworkserviceorder | grep -B1 "$active_device" | head -n 1 | sed 's/^([0-9]*) //' | sed 's/^[[:space:]]*//')

    if test -z "$service"
        # Fallback: try Wi-Fi first, then find first active service
        if networksetup -getinfo "Wi-Fi" 2>/dev/null | grep -q "IP address"
            echo "Wi-Fi"
        else
            networksetup -listallnetworkservices | tail -n +2 | head -n 1
        end
    else
        echo $service
    end
end

# Apply DNS to all network services
function dns-set-all
    set servers $argv
    for service in (networksetup -listallnetworkservices | tail -n +2)
        if test -n "$servers"
            sudo networksetup -setdnsservers "$service" $servers
        else
            sudo networksetup -setdnsservers "$service" empty
        end
    end
end

# Switch to Cloudflare DNS
function dns-cloudflare
    set service (dns-get-service)
    echo "Switching $service to Cloudflare DNS (1.1.1.1)..."
    sudo networksetup -setdnsservers "$service" 1.1.1.1 1.0.0.1
    dns-show
end

# Switch to Google DNS
function dns-google
    set service (dns-get-service)
    echo "Switching $service to Google DNS (8.8.8.8)..."
    sudo networksetup -setdnsservers "$service" 8.8.8.8 8.8.4.4
    dns-show
end

# Switch to Quad9 DNS
function dns-quad9
    set service (dns-get-service)
    echo "Switching $service to Quad9 (9.9.9.9)..."
    sudo networksetup -setdnsservers "$service" 9.9.9.9 149.112.112.112
    dns-show
end

# Switch to OpenDNS
function dns-opendns
    set service (dns-get-service)
    echo "Switching $service to OpenDNS..."
    sudo networksetup -setdnsservers "$service" 208.67.222.222 208.67.220.220
    dns-show
end

# Switch to automatic (router/DHCP)
function dns-auto
    set service (dns-get-service)
    echo "Switching $service to automatic DNS (router)..."
    sudo networksetup -setdnsservers "$service" empty
    dns-show
end

# Show current DNS servers
function dns-show
    set service (dns-get-service)
    echo "Current DNS servers for $service:"
    networksetup -getdnsservers "$service"
end

# Apply to ALL interfaces
function dns-cloudflare-all
    echo "Switching ALL network services to Cloudflare DNS..."
    dns-set-all 1.1.1.1 1.0.0.1
    dns-show
end

function dns-auto-all
    echo "Switching ALL network services to automatic DNS..."
    dns-set-all
    dns-show
end

# Main dns command
function dns
    if test (count $argv) -eq 0
        dns-show
    else
        switch $argv[1]
            case cloudflare cf
                if test "$argv[2]" = "all"
                    dns-cloudflare-all
                else
                    dns-cloudflare
                end
            case google
                dns-google
            case quad9
                dns-quad9
            case opendns
                dns-opendns
            case auto automatic router
                if test "$argv[2]" = "all"
                    dns-auto-all
                else
                    dns-auto
                end
            case show current
                dns-show
            case list
                echo "Available network services:"
                networksetup -listallnetworkservices | tail -n +2
            case help
                echo "DNS Switcher - Easy DNS management for macOS"
                echo ""
                echo "Usage: dns [command]"
                echo ""
                echo "Commands:"
                echo "  cloudflare, cf    Switch to Cloudflare DNS (1.1.1.1)"
                echo "  google            Switch to Google DNS (8.8.8.8)"
                echo "  quad9             Switch to Quad9 DNS (9.9.9.9)"
                echo "  opendns           Switch to OpenDNS"
                echo "  auto, router      Switch to automatic DNS (DHCP)"
                echo "  show, current     Show current DNS settings"
                echo "  list              List all network services"
                echo "  help              Show this help message"
                echo ""
                echo "Add 'all' to apply to all interfaces:"
                echo "  dns cloudflare all"
                echo "  dns auto all"
            case '*'
                echo "Unknown command: $argv[1]"
                echo "Run 'dns help' for usage information"
        end
    end
end
