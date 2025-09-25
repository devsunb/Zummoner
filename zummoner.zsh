zummoner() {
  local QUESTION="$BUFFER"
  local PROMPT="
  You are an expert Linux engineer with deep knowledge of all Linux commands and modern best practices.

  TASK: Generate exactly one shell command (or a pipeline of commands) that accomplishes the given task efficiently and safely.
  - The command will be executed directly in zsh.
  - Use sudo only when required.
  - Always assume the system info: $(uname -a). Current user is $USER.

  INSTRUCTIONS:
  - Output only the command, as a single plain-text line.
  - Do NOT include quotes, markdown, code blocks, explanations, or the shell name.
  - If parentheses are present, replace the text inside them.
  - If a comment (# ...) is present, interpret it as instructions and apply them, but do NOT include the comment itself in the output.

  PROMPT:
  Create a command to accomplish the following task: $QUESTION
  "
  # Determine provider (default: llm, option: claude)
  local provider="llm"
  local model=""

  if [[ -n "$ZUMMONER_PROVIDER" ]]; then
    provider="$ZUMMONER_PROVIDER"
    BUFFER="$QUESTION ... $(basename "$provider")"
  else
    if [[ -r "$HOME/$config/io.datasette.llm/default_model.txt" ]]; then
      model=$(cat "$HOME/$config/io.datasette.llm/default_model.txt")
    else
      model=$(llm models default)
    fi
    BUFFER="$QUESTION ... $provider ($model)"
  fi

  zle -R

  # Call appropriate provider
  if [[ "$provider" == "llm" ]]; then
    local response="$(llm <<<"$PROMPT")"
  else
    local response="$($provider $ZUMMONER_PROVIDER_OPTIONS <<<"$PROMPT" 2>/dev/null)"
  fi
  local COMMAND=$(echo "$response" | sed 's/```//g' | tr -d '\n')
  #echo "$(date %s) {$QUESTION | $response}" >> /tmp/zummoner
  if [[ -n "$COMMAND" ]]; then
    if [[ -n "$ZUMMONER_SPELL" ]]; then
      [[ "$QUESTION" = *"#"* ]] && QUESTION="${QUESTION#*\# }"
      BUFFER="${COMMAND%%\#*} # $QUESTION"
    else
      BUFFER="$COMMAND"
    fi
    CURSOR=${#BUFFER}
  else
    BUFFER="$QUESTION ... no results"
  fi
}

NN=0
zle -N zummoner

# This is the comment appending option, it will only work if
# this shell feature is on
if [[ -n "$ZUMMONER_SPELL" ]]; then
  setopt interactive_comments
fi

if ! bindkey | grep -q "\^Xx"; then
  bindkey '^Xx' zummoner
elif ! bindkey | grep -q zummoner; then
  echo "I'm not going to unbind ^Xx, you'll need to do this yourself"
fi
