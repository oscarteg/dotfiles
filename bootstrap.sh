#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git pull origin main

# Generic function to symlink subdirectories or files within a directory
# Usage: symlink_directory_contents <source_dir> <target_base> <dotfiles_dir> <symlink_files> [exclude1 exclude2 ...]
function symlink_directory_contents() {
	local source_dir="$1"
	local target_base="$2"
	local dotfiles_dir="$3"
	local symlink_files="$4"  # true for files, false for directories
	shift 4
	local excludes=("$@")

	if [[ ! -d "$source_dir" ]]; then
		return
	fi

	mkdir -p "$target_base"

	if [[ "$symlink_files" == "true" ]]; then
		# Symlink individual files
		for item in "$source_dir"/*; do
			if [[ -f "$item" ]]; then
				local item_name=$(basename "$item")

				# Check excludes
				local should_exclude=false
				for exc in "${excludes[@]}"; do
					if [[ "$item_name" == "$exc" ]]; then
						should_exclude=true
						break
					fi
				done
				if [[ "$should_exclude" == true ]]; then
					continue
				fi

				local target="$target_base/$item_name"

				if [[ -L "$target" ]]; then
					echo "Removing existing symlink: $target"
					rm "$target"
				elif [[ -f "$target" ]]; then
					echo "Backing up existing file: $target -> $target.backup"
					mv "$target" "$target.backup"
				fi

				echo "Creating symlink: $target -> $dotfiles_dir/$source_dir/$item_name"
				ln -s "$dotfiles_dir/$source_dir/$item_name" "$target"
			fi
		done
	else
		# Symlink subdirectories
		for item in "$source_dir"/*/; do
			if [[ -d "$item" ]]; then
				local item_name=$(basename "$item")

				# Check excludes
				local should_exclude=false
				for exc in "${excludes[@]}"; do
					if [[ "$item_name" == "$exc" ]]; then
						should_exclude=true
						break
					fi
				done
				if [[ "$should_exclude" == true ]]; then
					continue
				fi

				local target="$target_base/$item_name"

				if [[ -L "$target" ]]; then
					echo "Removing existing symlink: $target"
					rm "$target"
				elif [[ -d "$target" ]]; then
					echo "Backing up existing directory: $target -> $target.backup"
					mv "$target" "$target.backup"
				fi

				echo "Creating symlink: $target -> $dotfiles_dir/$source_dir/$item_name"
				ln -s "$dotfiles_dir/$source_dir/$item_name" "$target"
			fi
		done
	fi
}

function doIt() {
	local dotfiles_dir=$(pwd)
	local skip_files=(".git" ".DS_Store" ".config" ".ssh")

	# Symlink top-level dotfiles (excluding directories and special files)
	for file in .[^.]*; do
		# Skip directories
		if [[ -d "$file" ]]; then
			continue
		fi
		
		# Skip files in the skip array
		local should_skip=false
		for skip_file in "${skip_files[@]}"; do
			if [[ "$file" == "$skip_file" ]]; then
				should_skip=true
				break
			fi
		done
		if [[ "$should_skip" == true ]]; then
			continue
		fi

		local target="$HOME/$file"
		if [[ -L "$target" ]]; then
			echo "Removing existing symlink: $target"
			rm "$target"
		elif [[ -f "$target" ]]; then
			echo "Backing up existing file: $target -> $target.backup"
			mv "$target" "$target.backup"
		fi

		echo "Creating symlink: $target -> $dotfiles_dir/$file"
		ln -s "$dotfiles_dir/$file" "$target"
	done

	# Handle .config subdirectories individually (exclude opencode — has runtime files)
	symlink_directory_contents ".config" "$HOME/.config" "$dotfiles_dir" "false" "opencode"

	# Handle .ssh config files individually
	symlink_directory_contents ".ssh" "$HOME/.ssh" "$dotfiles_dir" "true"

	# Handle .config/opencode subdirectories (commands, agents, docs).
	# Skills now live in .agents/skills and are symlinked separately below.
	symlink_directory_contents ".config/opencode" "$HOME/.config/opencode" "$dotfiles_dir" "false" "skills"

	# Handle .config/opencode files (AGENTS.md)
	symlink_directory_contents ".config/opencode" "$HOME/.config/opencode" "$dotfiles_dir" "true"

	# Shared agent skills: one source dir (.agents/skills) linked into both the
	# general ~/.agents location and ~/.claude so Claude Code picks them up.
	for target in "$HOME/.agents/skills" "$HOME/.claude/skills"; do
		mkdir -p "$(dirname "$target")"
		if [[ -L "$target" ]]; then
			echo "Removing existing symlink: $target"
			rm "$target"
		elif [[ -d "$target" ]]; then
			echo "Backing up existing directory: $target -> $target.backup"
			mv "$target" "$target.backup"
		fi
		echo "Creating symlink: $target -> $dotfiles_dir/.agents/skills"
		ln -s "$dotfiles_dir/.agents/skills" "$target"
	done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
