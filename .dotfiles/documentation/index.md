# What

Store bash configuration in version control. Read a specific configuration based on detected environment details (OS, hostname, network). Be able to overlay/disable/enable a shared or user configuration.

# Why

Frustrating circumstances at work, of course. Plus, version control is pretty much always a good thing.

Mutliple locations I have worked would place user home on a network drive which was accessed by multiple computers and operating systems for different purposes. This could corrupt the history file, break one configuration by trying to improve another, etc.

Another issue is that while the IT team has administrative rights to change system-wide configuration files, they did not work on our system so did not know what or why any settings should change. The members of our team that know how our specific environment should be configured were not allowed to do it. Something as simple and necessary as configuring git to not ignore case in a single .gitconfig file is not easy. Think of the "shared" folders as a way to edit a system-wide configuration without needing administrative rights.

Git is a way to provide updates to files that do not have a built in mechanism. Cloning will provide a new user with a working environment and they will be able to get updates with just a couple of git commands.

Different tasks performed in the same home directory would lead to mistakes such as pressing up to rerun the wrong command or calling a script that is on the PATH because it is in the user's bin folder, but it is not meant to run in that particular environment.

# How

Use exepcted bash entry points such as .bash_profile so everything _just works_ without using changing symbolic links depending on which machine you are on like some other solutions need. This is taken from [Atlassian Dotfiles](https://www.atlassian.com/git/tutorials/dotfiles) tutorial. Attempt to use guidance from [Greg's Wiki](https://mywiki.wooledge.org/) for better practices. Google's [Shell Style Guide](https://google.github.io/styleguide/shellguide.html) is followed for formatting. File extensions are used to support editing on Windows where most of the work happens. 

Use wrapper scripts so commands are common for the user and configuration files, but the background behavior is not. For example, to edit a text file in Cygwin a user may want to use Notepad++ but they may want to use gedit on Linux. The same is true for configuration files that are not easily moved to a different location such as .gitconfig. If "editor.sh" is used to open Notepad++ on Cygwin and gedit on Linux, both the user's habits and the configuration will be more portable. Another option may be to set a variable such as GIT_EDITOR.

Provide a common version of a file when able, such as dotfiles.sh, but allow a user or environment-specific version to override. This can be done by prepending a folder to the PATH or setting a variable. In general, user overrides shared and environment overrides common configuration.

Avoid errors when the environment is not detected so the user can still work. They may want to add an environment after cloning. For example, a user may get a new computer with Apple OS which is not in dotfiles. Apple OS needs to work so that the user can perform general tasks as well as create an apple dotfiles folder and add it to the remote repository.

The dotfiles repository can be edited as a normal git repository. Clone, pull, checkout, edit, commit, and push. Use the dotfiles by running a git command specifying the location of the git repository and the worktree, usually the user's home directory then opening a new terminal to read the updated configuration.

# Shortcomings

Not all configuration files can be moved. For example, using a single .gitconfig file will not work with different versions of git that may be installed on different systems. Other files have similar issues.

Git worktree commands may fail if the directory where it is created is not accessible from all dotfiles types that try to access it. For example, if the worktree .git file says the gitdir is "C:/..." then a Linux machine will not be able to use that worktree.

# Architecture

.bash_profile, .bashrc, .profile - Expected entry points for bash process. Detect the environment and read the correct configuration. These will source all the other files to load the configuration.

load order - Profile, bash_profile, then bashrc. General then specific. Shared then user. This allows variables and settings to be set then modified. It also allows versions of scripts to be prioritized by prepending bin folders to the path in the aforementioned order.

profile.d, bash_profile.d, bashrc.d - folders containing modular profiles such as one to configure history, one to configure prompt, one to configure path, etc. These files will be read by a section of code that is provded in the template. If a single file is preferred then ignore these folders and modify the singular bashrc etc. Idea taken from [Ivan De Marino](https://github.com/detro/.bashrc.d).

.dotfiles/bash - Separate different types of shells for portabilty and future expansion.

shared, user - Each type is broken up into a shared folder for configuration management to configure and a user folder for an individual user to configure. Their structures tend to mirror one another.

bin - These folders hold files such as scripts that perform a task. They are added to the path variable so the files contained within should be available from the command line.

dotfiles_type_template - Skeleton for a specific environment containing expected files to avoid errors. Go to that direcotry and run the command `./template.sh <new environment folder name` to make a new OS. Use this as the default environment if the environment cannot be detected to avoid errors as they only contain print statements. Recommend naming types after the output of uname, domainname, hostname which is what set_dotfiles_type.sh uses to detect the type. For example, currently detecting Cygwin would use cygwin_na_na where na is "not applicable".

storage - Add licenses or other files that are useful when something goes wrong or working without network access.

wiki - Create guides or take notes.

# Variables 

DOTFILES_HOME - work-tree of files such as .bash_profile. It is used in files such as dotfiles.sh as a checkout destination. This should be set to the user home (${HOME}) for use and to the work area repo for testing (e.g. ${HOME}/git/dotfiles).

DOTFILES_REPO - Like DOTFILES_HOME but the git-dir instead of work-tree.

DOTFILES_DEBUG - Debug flag to enable debug prints when entering and leaving a file.

DOTFILES_SHARED - If true, read the configuration in the shared folders.

DOTFILES_USER - If true, read the configuration in the user folders.

DOTFILES_TYPE - The folder containing the specific setup for an environment.

# Scripts

dotfiles.sh - Run git commands with a specific git-dir and work-tree. Can also disable dangerous commands in .gitconfig under "[disabled]".

set_dotfiles_type.sh - Set DOTFILES_TYPE variable based on uname, domainname, and hostname.

show_dotfiles.sh - Print out the variables used in dotfiles architecture such as DOTFILES_REPO.

template.sh - Copy the contents of the dotfiles_type_template to a new folder. Note that the developer needs to add this type to set_dotfiles_type.sh.

# Types

[cygwin_na_na](cygwin_na_na.md)
