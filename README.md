# SHH

This set of scripts facilitates the process of decrypting SSH keys when using OpenSSH or related tools. This is accomplished by retrieving the passphrases from password-store, also known as `pass`, and injecting them via OpenSSH's `ASKPASS` functionality.

`ssh-keygen` does not integrate with `ASKPASS`, so there is a separate wrapper script, `shh-keygen`, to generate and store new, random passphrases in `pass`. It is also able to use pre-existing keys by either storing the old password or creating a new one.

## Example

`shh` expects encrypted SSH key filenames to exist under a `pass` folder specified by `SHH_PASS_DIR` which defaults to `SSH`.

Note: Once "`shh ssh-add ...`" is called, the pinentry dialog for the GPG key used for `pass` pops up.

```
$ pass ls
Password Store
└── SSH
    └── id_ed25519
$ shh ssh-add ~/.ssh/id_ed25519
Identity added: ../.ssh/id_ed25519
```

## Why use this??

It's easy to manage one or more keys without having to rely on an agent.
 
It's desktop-environment-agnostic.

## On the topic of multiple keys

Having one key per system is not necessarily going to provide additional security from a technical point of view.

That said, if you're privacy minded, then this may be appealing. By having a unique key per system you reduce the likelihood of your identity being cross-referenced when connecting to remote hosts.

For example, as of writing this readme it's still possible to retrieve the public key for users on GitHub through `https://github.com/<username>.keys`. It may be unlikely, but it's entirely possible for a remote system to attempt to identify a user's GitHub account when they connect by comparing their public key to known records. This can be avoided by using `shh-keygen` to create a separate, dedicated key for GitHub access.

By default, `ssh` will provide all known public keys when connecting, so the keyfiles must be explicitly mapped in `.ssh/config`:

```
Host github.com
    User foo
    IdentityFile /path/to/github/key
    IdentitiesOnly yes

Host *
    IdentityFile /path/to/general/key
    IdentitiesOnly yes
```

## Dependencies

- `pass` (https://www.passwordstore.org)
- `ssh`  (https://www.openssh.com)
