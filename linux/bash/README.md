# Bash
 - `/bin/sh` is the default  shelll since the very first days of Unix.
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

## Substitution Operator Examples
 - ${VAR:-word}: if $VAR exists, use its value, if not, return the value "word". This does NOT set the variable.
 - ${VAR:=word}: if $VAR exists, use its value, if not, set the default value to "word".
 - ${VAR:?message}: if $VAR exists, show its value. If not, display VAR followed by message. If message is omitted, the message VAR: parameter null or not set will be shown.
 - ${VAR:offset:length}: if $VAR exists, show the substring of $VAR, starting at offset with a length of *length*.

## Pattern Matching Operators
 - ${VAR#pattern}: Search for pattern from the beginning of variable's value, delete the shortest part that matches, and return the rest:

```bash
FILENAME=/usr/bin/blah
echo ${FILENAME#*/}
> usr/bin/blah
```

 - ${VAR##pattern}: Search for pattern from the beginning of variable's value, delete the longest part that matches, and return the rest:

``` bash
FILENAME=/usr/bin/blah
echo ${FILENAME##*/}
> blah
```

 - ${VAR%pattern}: If pattern matches the end of variable's value, delete the shortest part that matches, and return the rest:

```bash
FILENAME=/usr/bin/blah
echo ${FILENAME%*/}
> usr/bin/blah
```

 - ${VAR%%pattern}: If pattern matches the end of variable's value, delete the longest part that matches, and return the rest:

``` bash
FILENAME=/usr/bin/blah
echo ${FILENAME%%*/}
> blah
```

## Regular expressions
Use them within single quotes, so they are not interpreted as wildcards and so on.

| Regular Expression | Use |
| ------------------ | --- |
| ^text              | Line starts with text |
| text$              | Line ends with text |
| .                  | Wildcard (Matches any single character) |
| [abc], [a-c]       | Matches a, b or c |
| *                  | Matches 0 to an infinite number of the previous character |
| \{2\}              | Matches exactly 2 of the previous character |
| \{1,3\}            | Matches a minimum of 1 and a maximum of 3 of the previous character |
| colou?r            | Match 0 or 1 of the previous character (which makes the previous character optional |

## Calculating

- Internal calculation: `$(( 1 + 1 ))`

- External calculation **let**:

``` bash
#!/bin/bash
# $1 is the first number
# $2 is the operator
# $3 is the second number
let x="$1 $2 $3"
echo $x
```
- External calculation with bc
    - bc is developed as a calculator with its own shell interface
    - It can deal with more than just integers
    - Use bc in non-interactive mode:
        - `echo "scale=9; 10/3"| bc`
    - Or in a variable:
        - `VAR=$(echo "scale=9; 10/3" | bc)`

## grep

grep is a very flexible tool to search for text patterns based on regular expressions:
    - grep -i: case insensitive
    - grep -v: exclude lines that match the pattern
    - grep -r: recursive
    - grep -e: matches more regular expressions (`grep -e 'what' -e 'else'`)
    - grep -A5: shows 5 lines after the matching regex
    - grep -B4: shows 5 lines before the matching regex

## test

Allows for testing of many items:
    - expression: test ( ls /etc/hosts )
    - string: test -z $1
    - integers: test $1=6
    - file comparisons: test file1 -nt file2
    - file properties: test -x file1
