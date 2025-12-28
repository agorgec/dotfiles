function fish_greeting
    set_color blue
    echo "󰆍  "(whoami)"@"(hostname)
    set_color cyan
    echo "󰻀  Uptime: "(uptime -p | string replace "up " "")
    set_color normal
end
