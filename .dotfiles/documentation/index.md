# What

Store bash configuration in version control. Read a specific configuration based on detected environment details (OS, hostname, network). Be able to overlay/disable/enable a shared or user configuration.

# Why

Frustrating circumstances at work, of course. Plus, version control is pretty much always a good thing.

Mutliple locations I have worked would place user home on a network drive which was accessed by multiple computers and operating systems for different purposes. This could corrupt the history file, break one configuration by trying to improve another, etc.

Another issue is that while the IT team has administrative rights to change system-wide configuration files, they did not work on our system so did not know what or why any settings should change. The members of our team that know how our specific environment should be configured were not allowed to do it. Something as simple and necessary as configuring git to not ignore case in a single .gitconfig file is not easy. Think of the "shared" folders as a way to edit a system-wide configuration without needing administrative rights.

Git is a way to provide updates to files that do not have a built in mechanism. Cloning will provide a new user with a working environment and they will be able to get updates with just a couple of git commands.

Different tasks performed in the same home directory would lead to mistakes such as pressing up to rerun the wrong command or calling a script that is on the PATH because it is in the user's bin folder, but it is not meant to run in that particular environment.

# How

Use exepcted bash entry points such as .bash_profile so everything _just works_ without using changing symbolic links depending on which machine you are on like some other solutions need. This is taken from [Atlassian Dotfiles](https://www.atlassian.com/git/tutorials/dotfiles) tutorial. Attempt to use guidance from [Greg's Wiki](https://mywiki.wooledge.org/) for better practices.

Use wrapper scripts so commands are common for the user and configuration files, but the background behavior is not. For example, to edit a text file in Cygwin a user may want to use Notepad++ but they may want to use gedit on Linux. The same is true for configuration files that are not easily moved to a different location such as .gitconfig. If "editor.sh" is used to open Notepad++ on Cygwin and gedit on Linux, both the user's habits and the configuration will be more portable. Another option may be to set a variable such as GIT_EDITOR.

Provide a common version of a file when able, such as dotfiles.sh, but allow a user or environment-specific version to override. This can be done by prepending a folder to the PATH or setting a variable. In general, user overrides shared and environment overrides common configuration.

Avoid errors when the environment is not detected so the user can still work. They may want to add an environment after cloning. For example, a user may get a new computer with Apple OS which is not in dotfiles. Apple OS needs to work so that the user can perform general tasks as well as create an apple dotfiles folder and add it to the remote repository.

The dotfiles repository can be edited as a normal git repository. Clone, pull, checkout, edit, commit, and push. Use the dotfiles by running a git command specifying the location of the git repository and the worktree, usually the user's home directory then opening a new terminal to read the updated configuration.

# Shortcomings

Not all configuration files can be moved. For example, using a single .gitconfig file will not work with different versions of git that may be installed on different systems. Other files have similar issues.

# Architecture

.bash_profile, .bashrc, .profile - Expected entry points for bash process. Detect the environment and read the correct configuration. For example, .bash_profile will source the detected environment's shared then user bash_profile if they are enabled so that the user can modify any settings from the shared version such as shopt autocd. It will modify the PATH by prepending in this order: user environment, shared environment, user general, shared general. Finally, it will source .bashrc.

profile.d, bash_profile.d, bashrc.d - folders containing small profiles such as one to configure history, one to configure prompt, one to configure path, etc. These files will be read by a section of code that is provded in the template. If a single file is preferred then ignore this functionality. Idea taken from [Ivan De Marino](https://github.com/detro/.bashrc.d).

.dotfiles/bash - Separate different types of shells for portabilty and future expansion.

template - Skeleton for a specific environment containing expected files to avoid errors. Go to that direcotry and run the command `template.sh <new environment folder name` to make a new OS. Use this as the default environment if the environment cannot be detected to avoid errors as they only contain print statements.

storage - Add licenses or other files that are useful when something goes wrong or teleworking.

wiki - Create guides or take notes.