#!/usr/bin/env bash

repos=()
while IFS= read -d '' -r; do
	repos+=("${REPLY}")
done < <(find "${HOME}/git" -mindepth 1 -maxdepth 1 -type d -print0)

for repo in "${repos[@]}"; do
	case "$(basename "${repo}")" in
	*)
		echo "Repo is: ${repo}"
		git -C "${repo}" fetch --all --recurse-submodules "${@}"
	;;
	esac
done