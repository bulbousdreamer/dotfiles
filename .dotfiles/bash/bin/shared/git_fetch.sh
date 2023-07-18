#!/usr/bin/bash

repos=()
while IFS= read -d '' -r; do
	repos+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/git" -mindepth 1 -maxdepth 1 -type d -print0)

for repo in "${repos[@]}"; do
	case "$(basename "${repo}")" in
	*)
		git -C "${repo}" fetch --all --recurse-submodules ${1:-}
	;;
	esac
done
