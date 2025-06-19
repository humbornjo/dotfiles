# function kp --description "Kill processes"
#   set -l __kp__pid (sudo ps ax | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]'" | awk '{print $2}')
#   set -l __kp__kc $argv[1]
#
#   if test "x$__kp__pid" != "x"
#     if test "x$argv[1]" != "x"
#       echo $__kp__pid | xargs kill $argv[1]
#     else
#       echo $__kp__pid | xargs kill -9
#     end
#     kp
#   end
# end

function kp --description "Kill processes with optional sudo password"
  # Define the help message
  set -l help_message "
Usage: kp [OPTIONS]

Kill processes interactively using fzf.

Options:
  -p, --password <password>   Provide sudo password directly (use with caution, as it may expose
                              your password in shell history).
  -s, --signal <signal>     Specify the kill signal to send (e.g., SIGTERM, 15, -9).
                              Defaults to -9 (SIGKILL).
  -h, --help                Display this help message and exit.

Examples:
  kp                        # Select processes to kill (will prompt for sudo password if needed)
  kp -p your_sudo_password  # Select processes, providing password directly (use with caution)
  kp -s SIGTERM             # Select processes, send SIGTERM (signal 15)
  kp -s 15 -p your_password # Select processes, send signal 15, provide password
"

  # Parse command-line arguments, including help flags
  argparse 'p/password=' 's/signal=' 'h/help' -- $argv
  or begin
    # If argparse fails, it usually means invalid arguments. Display help.
    echo "$help_message"
    return 1
  end

  # Check for help flags
  if set -q _flag_help
    echo "$help_message"
    return 0
  end

  set -l sudo_cmd "ps ax"
  if set -q _flag_password
    set sudo_cmd "echo $_flag_password | sudo -S ps ax"
  else
    set sudo_cmd "sudo ps ax"
  end

  # Execute the ps command and pipe to fzf with explicit options
  # We're passing the options directly to fzf, overriding FZF_DEFAULT_OPTS if it exists.
  set -l __kp__pid_output (eval "$sudo_cmd" | sed 1d | eval "fzf --height=100% -m --header='[kill:process] Select process(es) to kill:'" | awk '{print $2}')

  if test -z "$__kp__pid_output"
    echo "No process selected. Exiting."
    return
  end

  # Extract PIDs from fzf's output
  set -l __kp__pids (echo "$__kp__pid_output" | awk '{print $1}')

  set -l kill_signal "-9" # Default to SIGKILL

  if set -q _flag_signal
    set kill_signal $_flag_signal
  end

  for pid in $__kp__pids
    echo "Attempting to send signal $kill_signal to PID: $pid"
    if test -n "$_flag_password"
      echo "$_flag_password" | sudo -S kill "$kill_signal" "$pid"
    else
      sudo kill "$kill_signal" "$pid"
    end
  end

  echo "Successfully sent signal $kill_signal to processes: $__kp__pids"
end
