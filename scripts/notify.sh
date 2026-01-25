#!/bin/bash
# Cross-platform notification script for Claude Code hooks
# Supports: macOS, Windows WSL, VS Code terminals

TITLE="${1:-Claude Code}"
MESSAGE="${2:-Task completed}"

# Detect environment
is_wsl() {
    grep -qi microsoft /proc/version 2>/dev/null
}

is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

is_vscode_terminal() {
    [[ -n "${TERM_PROGRAM}" && "${TERM_PROGRAM}" == "vscode" ]] || \
    [[ -n "${VSCODE_INJECTION}" ]] || \
    [[ -n "${VSCODE_GIT_IPC_HANDLE}" ]]
}

# VS Code notification using terminal bell + title
notify_vscode() {
    # Terminal bell (triggers VS Code notification if configured)
    printf '\a'
    # Also update terminal title which VS Code shows
    printf '\033]0;%s\007' "$MESSAGE"
}

# macOS notification
notify_macos() {
    if command -v terminal-notifier &>/dev/null; then
        terminal-notifier -title "$TITLE" -message "$MESSAGE" -sound default
    else
        # Fallback to osascript
        osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"Glass\""
    fi
}

# Windows/WSL notification using PowerShell toast
notify_wsl() {
    local ps_path=""

    # Find PowerShell
    if command -v powershell.exe &>/dev/null; then
        ps_path="powershell.exe"
    elif [[ -x "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" ]]; then
        ps_path="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
    fi

    if [[ -n "$ps_path" ]]; then
        # Use BurntToast if available, otherwise use basic Windows toast
        "$ps_path" -NoProfile -Command "
            \$null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
            \$template = [Windows.UI.Notifications.ToastTemplateType]::ToastText02
            \$xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent(\$template)
            \$text = \$xml.GetElementsByTagName('text')
            \$text[0].AppendChild(\$xml.CreateTextNode('$TITLE')) | Out-Null
            \$text[1].AppendChild(\$xml.CreateTextNode('$MESSAGE')) | Out-Null
            \$toast = [Windows.UI.Notifications.ToastNotification]::new(\$xml)
            \$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Claude Code')
            \$notifier.Show(\$toast)
        " 2>/dev/null

        # Fallback: also play a sound via PowerShell
        if [[ $? -ne 0 ]]; then
            "$ps_path" -NoProfile -Command "[console]::beep(800,200)" 2>/dev/null
        fi
    fi
}

# Linux native notification
notify_linux() {
    if command -v notify-send &>/dev/null; then
        notify-send "$TITLE" "$MESSAGE"
    fi
}

# Main logic - try environment-specific notification
main() {
    # VS Code gets terminal bell regardless of platform
    if is_vscode_terminal; then
        notify_vscode
    fi

    # Platform-specific notification
    if is_macos; then
        notify_macos
    elif is_wsl; then
        notify_wsl
    else
        notify_linux
    fi
}

main
