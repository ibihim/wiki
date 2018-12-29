# Bash 
 - `/bin/sh` is the default  shelll since the very first days of Unix .
 - `/bin/bash` is the most common shell on Linux and other Unices.
 - Large parts of the OS and its applications are written in bash.

 - Exit status of the last command: `echo $?`
 - Is a good resource for look ups: tldp.org

 - An **argument** is anything that can be used after a command: `ls -l /etc` has two arguments.
 - An **option** is an argument that was specifically developed to change the command behavior.
 - A **parameter** is a name that is defined in a script to which a specific value is granted.
 - A **variable** is a label that is stored in memory and contains a specific value (e.g. PATH).

 - `bash -x scrip.sh`, prints all commands executing. Good for debugging.

## Variables
 - Create a summary of the variables at the top of the script.
 - How to define:
 	- Static declaration: `VARNAME=value`
 	- As an argument to a script, handled using $1, $2 etc. within the script
	- Interactively, using *read*.
 - Best Practice: use uppercase for names.

## Environment
 - Use export to make the variable available in sub shells.
 - Running a script happens in a sub shell.
 - **source** imports a particular script.
 	- Seperate fixed code from dynamic code.
 - /etc/profile is processed when opening a login shell.
 - /etc/bashrc is processed when opening a subshell.

## Quoting
 - Special characters are interpreted, known as *command line parsing*
 - Except: Single quotes prohibit interpreting of variables.
 - Except: Backslash avoid interpretation of the next character.
 - Best Practice: Use single quotes, until you wants explicitly interpretation.

## Arguments
 - $1, $2, ... refer to first, second, etc. argument
 - $0 refers to the name of the script itself.
 - Use ${nn} or shift to refer to arguments beyond 9.
 - $1, ... are read only.
 - **shift** moves $2 onto $1.

## Command  Substitution
 - Command substitution allows using the result of a command in a script.
 - Two allowed syntaxes:
 	- `command` (deprecated)
	- $(command) (preferred)

