
# Zummoner: ✨ The Zsh Spellbook ✨

**Invoke the power of the command line with a whisper!**

Tired of remembering complex commands? 🧙‍♂️ Zummoner is a Zsh plugin that *summons* the right command for you, using the magic of a Large Language Model (LLM). Just describe what you want to do, and Zummoner does the rest!

![440177965-01488c16-fb68-4fdb-a7ea-76e12499641d](https://github.com/user-attachments/assets/e272d159-66c9-445a-8f82-4f545a5ddae6)


## Features - The Enchantments 🪄

* **Command Conjuration:** Describe your task in plain English, and Zummoner generates the command. ✨
* **System Aware:** Knows your system (`uname -a`) and user for tailored spells. 🤖
* **Modern Magic:** Prefers modern tools like `homectl`, `ip`, `systemctl`, and `journalctl`. 🚀
* **Safety First:** Commands are vetted for reliability (but *always* review before running!). 🛡️
* **Customizable LLM:** Pick your favorite LLM model! 🧠
* **Seamless Integration:** Works directly within your Zsh shell. 🐚

## Installation - Binding the Spirit 🔗
You cann zplug, zinit, zgen it ... it's the right format orrrr manually:

   ```bash
   git clone https://github.com/day50-dev/zummoner.git $HOME/.local/zummoner
   echo source \$HOME/.local/zummoner/zummoner.zsh >> $HOME/.zshrc
   source $HOME/.zshrc
   
   ```

**Keybinding:**  Zummoner uses `^Xx` (Ctrl+x, then x) by default.  It'll let you know if that key is already taken!

## Usage - Uttering the Incantation 🗣️

1. Type what you want to do (e.g., "list all files in the current directory sorted by size").
2. Press `^Xx`.
3. Zummoner will show the command!
4. Press Enter to execute. 💥

## Configuration Options ⚙️

### AI Provider Selection
Choose your AI provider by setting the environment variable:

```bash
# Use LLM (simon w's llm tool) - default
export ZUMMONER_PROVIDER=llm

# Use Claude Code CLI
export ZUMMONER_PROVIDER=~/.claude/local/claude
export ZUMMONER_PROVIDER_OPTIONS=-p

# Use Gemini CLI
export ZUMMONER_PROVIDER=gemini
export ZUMMONER_PROVIDER_OPTIONS=-p
```

### Incremental Spellcasting
Set the variable before inclusion!
```bash
ZUMMONER_SPELL=1
```
And you will get commented spell casts that you can incrementally modify like below!

![zummoner](https://github.com/user-attachments/assets/f639fa9c-a28c-41a1-9d1a-f6ff7faab15e)

## Caveats - A Little Magic Caution ⚠️

* **LLM Required:** Zummoner needs access to [simon w's llm](https://github.com/simonw/llm) or other llm cli.
* **Network Connection:**  Requires internet access to reach the LLM.
* **Review Commands:** Always check the generated command, *especially* if it uses `sudo`!
* **System Differences:** Commands may need tweaking depending on your Linux distribution. 

## The future!

This project was a prototype [for something much more ambitious](https://news.ycombinator.com/item?id=44112949) of what is now called [ono](https://onolang.com/).
