set -g -x PATH /usr/local/bin $PATH
set -x PATH $HOME/.fastlane/bin $PATH
set -x PATH /usr/local/opt/ruby/bin $PATH
set -x PATH /usr/local/lib/ruby/gems/2.6.0/bin $PATH
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
set -x GIHUB_TOKEN "9ae44b28d7e34c7bc1ec7546ce69312325190f55"
set -x BROWSER "chrome"

function fish_prompt
  env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.shell_prompt.sh left
end

function fish_right_prompt
  env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.shell_prompt.sh right
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
