
# Dotfiles Repository

Store bash configuration in version control. Read a specific configuration based on detected environment details (OS, hostname, network). Be able to overlay/disable/enable a shared (configuration management) or user configuration.

## Implementations

[cygwin_na_na](cygwin_na_na.md)

## Background

Frustrating circumstances at work, of course. Plus, version control is pretty much always a good thing.

Some work environments place user home on a network drive which was accessed by multiple computers and operating systems for different purposes at the same time. This could corrupt the history file, break one configuration by trying to improve another, etc.

Another issue is that while the IT team has administrative rights to change system-wide configuration files, they did not do development work so did not know what or why any settings should change. The team members that did have that knowledge were not administrators and were not allowed to modify system files or settings. Think of the "shared" folders as a way to edit a system-wide configuration without needing administrative rights.

Git is a way to provide updates to files that do not have a built in mechanism. Cloning will provide a new user with a working environment and they will be able to get updates with just a couple of git commands.

Different tasks performed in the same home directory would lead to mistakes such as pressing up to rerun the wrong command or calling a script that is on the PATH because it is in the user's bin folder, but it is not meant to run in that particular environment.

## Solution

Use exepcted bash entry points such as .bash_profile so everything _just works_. This is taken from [Atlassian Dotfiles](https://www.atlassian.com/git/tutorials/dotfiles) tutorial. Attempt to use guidance from [Greg's Wiki](https://mywiki.wooledge.org/) for better practices. Google's [Shell Style Guide](https://google.github.io/styleguide/shellguide.html) is followed for formatting. File extensions are used to support syntax highlighting when editing on Windows which is where most of the work happens.

Use wrapper scripts so commands are common for the user and configuration files, but the background behavior is not. For example, to edit a text file in Cygwin a user may want to use Notepad++ but they may want to use gedit on Linux. The same is true for configuration files that are not easily moved to a different location such as .gitconfig. If editor.sh is used to open Notepad++ on Cygwin and gedit on Linux, both the user's habits and the configuration will be more portable. Another option may be to set a variable such as GIT_EDITOR.

Provide a common version of a file when able, such as dotfiles.sh, but allow a user or environment-specific version to override. This can be done by prepending a folder to the PATH or setting a variable. In general, user overrides shared and environment overrides common configuration.

Avoid errors when the environment is not detected so the user can still work. They may want to add an environment after cloning. For example, a user may get a new computer with Apple OS which is not in dotfiles. Apple OS needs to work so that the user can perform general tasks as well as create an apple dotfiles folder and add it to the remote repository.

The dotfiles repository can be edited as a normal git repository. Clone, pull, checkout, edit, commit, and push. Use the dotfiles by running a git command specifying the location of the git repository and the worktree, usually the user's home directory then opening a new terminal to read the updated configuration.

## Architecture

### Homes

Take a general home directory structure:

```
HOME
├── bash_profile
├── bash_profile.d
├── bashrc
├── bashrc.d
├── bin
├── profile
├── profile.d
└── storage
```

In the dotfiles repository, this pattern is repeated in three levels, usually in pairs of shared and user folders.

The top level supports Bash and dotfiles repository behavior by providing .bash_profile entry points, for example. These are Bash initialization files and serve only to read the second and third levels.

The second level is the generic shared and user folders that have scripts or settings used in all dotfiles types. For example, the git_fetch.sh script is simple, may not need customized, and provided by the dotfiles maintainer, so it goes in .dotfiles/bash/bin/shared. If a user keeps their git repositories in a different place, they can modify `find "${HOME}/git"` to be `find "/path/to/their/git/repositories")` and saving the modified file as .dotfiles/bash/bin/user/git_fetch.sh. The user bin folder is found earlier in the PATH than and therefore called instead of the shared version. The user and maintainers are not modifying the same file and fighting with one another over changes. The user does not keep an eye out for important shared changes that may need to be put into their user version.

The third level is specific to the detected environment. For example, a user may have an environment with a backup Git respositories directory in addition to the commonly used in HOME/git. They could do this by changing dotfiles/bash/bin/shared/git_fetch.sh line `repos=()` to `repos=("/path/to/git/backups")` and saving the modified file to .dotfiles/bash/some_dotfiles_env/user/bin/git_fetch.sh. The third level user bin folder is found earlier in the PATH than and therefore called instead of the third level shared, both second level, and both third level versions.

Full view (example only):

```
.
├── .bash_profile
├── .bashrc
├── .dotfiles
│   ├── .editorconfig
│   ├── bash
│   │   ├── cygwin_na_na
│   │   │   ├── shared
│   │   │   │   ├── .gitignore
│   │   │   │   ├── bash_profile
│   │   │   │   ├── bash_profile.d
│   │   │   │   │   ├── .gitignore
│   │   │   │   │   └── path.sh
│   │   │   │   ├── bashrc
│   │   │   │   ├── bashrc.d
│   │   │   │   │   └── .gitignore
│   │   │   │   ├── bin
│   │   │   │   │   ├── .gitignore
│   │   │   │   │   ├── bcdiff.txt
│   │   │   │   │   ├── dotfiles.sh
│   │   │   │   │   ├── editor.sh
│   │   │   │   │   ├── git_editor.sh
│   │   │   │   │   ├── git_ext_diff.sh
│   │   │   │   │   ├── git_ext_diff_report.sh
│   │   │   │   │   └── git_ext_merge.sh
│   │   │   │   ├── profile
│   │   │   │   ├── profile.d
│   │   │   │   │   └── .gitignore
│   │   │   │   └── storage
│   │   │   │       ├── .gitignore
│   │   │   │       └── null_file
│   │   │   └── user
│   │   │       ├── bash_profile
│   │   │       ├── bash_profile.d
│   │   │       │   └── .gitignore
│   │   │       ├── bashrc
│   │   │       ├── bashrc.d
│   │   │       │   └── .gitignore
│   │   │       ├── bin
│   │   │       │   └── .gitignore
│   │   │       ├── profile
│   │   │       ├── profile.d
│   │   │       │   └── .gitignore
│   │   │       └── storage
│   │   │           └── .gitignore
│   │   ├── dotfiles_type_template
│   │   │   ├── shared
│   │   │   │   ├── .gitignore
│   │   │   │   ├── bash_profile
│   │   │   │   ├── bash_profile.d
│   │   │   │   │   └── .gitignore
│   │   │   │   ├── bashrc
│   │   │   │   ├── bashrc.d
│   │   │   │   │   └── .gitignore
│   │   │   │   ├── bin
│   │   │   │   │   └── .gitignore
│   │   │   │   ├── profile
│   │   │   │   ├── profile.d
│   │   │   │   │   └── .gitignore
│   │   │   │   └── storage
│   │   │   │       └── .gitignore
│   │   │   ├── template.sh
│   │   │   └── user
│   │   │       ├── bash_profile
│   │   │       ├── bash_profile.d
│   │   │       │   └── .gitignore
│   │   │       ├── bashrc
│   │   │       ├── bashrc.d
│   │   │       │   └── .gitignore
│   │   │       ├── bin
│   │   │       │   └── .gitignore
│   │   │       ├── profile
│   │   │       ├── profile.d
│   │   │       │   └── .gitignore
│   │   │       └── storage
│   │   │           └── .gitignore
│   │   ├── shared
│   │   │   ├── bash_profile.d
│   │   │   │   ├── .gitignore
│   │   │   │   ├── history.sh
│   │   │   │   ├── path.sh
│   │   │   │   └── shopt.sh
│   │   │   ├── bashrc.d
│   │   │   │   └── .gitignore
│   │   │   ├── bin
│   │   │   │   ├── .gitignore
│   │   │   │   ├── dotfiles.sh
│   │   │   │   ├── git_fetch.sh
│   │   │   │   ├── set_dotfiles_type.sh
│   │   │   │   └── show_dotfiles.sh
│   │   │   └── profile.d
│   │   │       └── .gitignore
│   │   └── user
│   │       ├── bash_profile.d
│   │       │   └── .gitignore
│   │       ├── bashrc.d
│   │       │   └── .gitignore
│   │       ├── bin
│   │       │   └── .gitignore
│   │       └── profile.d
│   │           └── .gitignore
│   └── documentation
│       ├── .gitignore
│       ├── cygwin_na_na.md
│       └── index.md
├── .editorconfig
├── .git
├── .gitconfig
└── .profile
```

### .bash_profile, .bashrc, .profile

Expected entry points for bash process. Detect the environment and read the correct configuration. These will source all the other files to load the configuration.

### Load Order

Profile, bash_profile, then bashrc. General then specific. Shared then user. This allows variables and settings to be set then modified. It also allows versions of scripts to be prioritized by prepending bin folders to the path in the aforementioned order.

### profile.d, bash_profile.d, bashrc.d Directories

Folders containing modular profiles such as one to configure history, one to configure prompt, one to configure path, etc. These files will be read by a section of code that is provded in the template.

Using separate files makes it easier to copy and modify similar settings to multiple folders, but if a single file is preferred then ignore these folders and modify the singular bashrc file itself.

### .dotfiles/bash

Separate different types of shells for portabilty and future expansion.

### shared, user Directories

Each type is broken up into a shared folder for configuration management to configure and a user folder for an individual user to configure. Their structures tend to mirror one another.

### bin Directory

These folders hold files such as scripts that perform a task. They are added to the path variable so the files contained within should be available from the command line.

### dotfiles_type_template Directory

Skeleton for a specific environment containing expected files to avoid errors. Go to that direcotry and run the command `./template.sh <new environment folder name>` to make a new OS. Use this as the default environment if the environment cannot be detected to avoid errors as they only contain print statements. Recommend naming types after the output of uname, domainname, hostname which is what set_dotfiles_type.sh uses to detect the type. For example, currently detecting Cygwin would use cygwin_na_na where na is "not applicable". This script uses a case statement so order the types from specific to generic.

### storage Directory

Add licenses or other files that are useful when something goes wrong or working without network access.

### wiki Directory

Create guides or take notes. Hint: VS Code is useful for rendering markdown.

### Variables

DOTFILES_HOME - work-tree of files such as .bash_profile. It is used in files such as dotfiles.sh as a checkout destination. This should be set to the user home (${HOME}) for use and to the work area repo for testing (e.g. ${HOME}/git/dotfiles).

DOTFILES_REPO - Like DOTFILES_HOME but the git-dir instead of work-tree.

DOTFILES_DEBUG - Debug flag to enable debug prints when entering and leaving a file.

DOTFILES_SHARED - If true, read the configuration in the shared folders.

DOTFILES_USER - If true, read the configuration in the user folders.

DOTFILES_TYPE - The folder containing the specific setup for an environment.

### Scripts

dotfiles.sh - Run git commands with a specific git-dir and work-tree. Can also disable dangerous commands in .gitconfig under "[disabled]".

set_dotfiles_type.sh - Set DOTFILES_TYPE variable based on uname, domainname, and hostname.

show_dotfiles.sh - Print out the variables used in dotfiles architecture such as DOTFILES_REPO.

template.sh - Copy the contents of the dotfiles_type_template to a new folder. Note that the developer needs to add this type to set_dotfiles_type.sh.

### Nested Repositories

It is appealing to use a fancy prompt found on github. Not sure how best to do this. Maybe clone to the storage folder and add fancy_prompt.sh to bash_profile.d to source it? Submodule or subtree?

## Issues

Not all configuration files can be moved. For example, using a single .gitconfig file will not work with different versions of git that may be installed on different systems. Other files have similar issues.

Git worktree commands may fail if the directory where it is created is not accessible from all dotfiles types that try to access it. For example, if the worktree .git file says the gitdir is "C:/..." then a Linux machine will not be able to use that worktree.

Balancing automation and poor design. For example, DOTFILES_DEBUG statements were initially hardcoded to not depend on a variable that could be set differently and print misleading information, but manually updating was tedious. Many users will want Git information on their PS1 prompt, but in the past adding a generic one caused errors in some dotfiles types. Some systems such as Git for Windows come with it and configure it automatically in `/etc/profile.d/git-prompt.sh`. Currently leaving it up to the specific dotfiles type to configure its own. Theoretically it just needs added to the appropriate bash_profile.d folder.
