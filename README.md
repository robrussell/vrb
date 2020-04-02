# vrb

vimrc, readline, bashrc, maybe some other configs.

Common configuration that can be used across machines is stored here. On any
given machine, either symlink to the file in this repo as the entire config file
or create a local file and include the file from this repo.

This repo is cloned on one machine at ~/code/vrb in the examples below.

## vimrc

The local configuration at ~/.vimrc contains

```
source ~/code/vrb/vimrc
```

## inputrc

The local readline configuration at ~/.inputrc contains

```
# some local machine-specific configuration

$include ~/code/vrb/inputrc

```

## bashrc

The local bash configuration at ~/.bashrc contains

```
# lots of local configuration

source ~/code/vrb/bashrc

```
