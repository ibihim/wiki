# GPG

# Generate GPG key pair

Recommneded values:
 - RSA
 - Key size 4096

```bash
$ gpg --full-generate-key
```

## Generating a revocation certificate

Yeah, just do it. It might be handy sometime in the future.

```bash
$ gpg --outpout revoke.asc --gen-revoke mykey
```

## List GPG keys

```bash
$ gpg --list-secret-keys --keyid-format LONG

/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot
ssb   4096R/42B317FD4BA89E7A 2016-03-10
```

GPG key id in this example: `3AA5C34371567BD2`.

## Export public key

```bash
$ gpg --armor --output alice.gpg --export alice@cyb.org
```

## Importing a public key

```bash
$ gpg --import bob.gpg

gpg: key 9E98BC16: public key imported
gpg: Total number processed: 1
gpg:               imported: 1

$ gpg --list-keys

/users/alice/.gnupg/pubring.gpg
---------------------------------------
pub  1024D/BB7576AC 1999-06-04 Alice (Judge) <alice@cyb.org>
sub  1024g/78E9A8FA 1999-06-04

pub  1024D/9E98BC16 1999-06-04 Bob (Executioner) <bob@cyb.org>
sub  1024g/5C8CBD41 1999-06-04
```

A key is validated by verifying the key's fingerprint and signing
the key to certify it is a valid key.

## Generate Fingerprint

To validate they key. E.g. in face to face communication.

```bash
$ gpg --fingerprint bob@cyb.org

pub 4096R/ED873D23 2018-06-22
Key fingerprint = EC23 92F2 EDE7 4488 680D A3CF 5F2B 4756 ED87 3D23
uid Firstname Lastname<your@email.address>
sub 4096R/5314E70B 2018-06-22
```

Or

```bash
$ gpg --edit-key bob@cyb.org

pub  1024D/9E98BC16  created: 1999-06-04 expires: never      trust: -/q
sub  1024g/5C8CBD41  created: 1999-06-04 expires: never
(1)  Bob (Executioner) <bob@cyb.org>

Command> fpr
pub  1024D/9E98BC16 1999-06-04 Bob (Executioner) <bob@cyb.org>
             Fingerprint: 268F 448F CCD7 AF34 183E  52D8 9BDE 1A08 9E98 BC16
```

## Signing Keys

GPG has no reason to trust any public key until not signed. And you should sign
carefully as this is a weakspot. Only verify by exchanging fingerprints face to
face... or voice, if known... or keybase? :D

```bash
$ gpg --sign-key bob@cyb.org
```

Or **better**

```bash
$ gpg --edit-key bob@cyb.org

pub  1024D/9E98BC16  created: 1999-06-04 expires: never      trust: -/q
sub  1024g/5C8CBD41  created: 1999-06-04 expires: never
(1)  Bob (Executioner) <bob@cyb.org>

Command> sign

pub  1024D/9E98BC16  created: 1999-06-04 expires: never      trust: -/q
             Fingerprint: 268F 448F CCD7 AF34 183E  52D8 9BDE 1A08 9E98 BC16

     Bob (Executioner) <bob@cyb.org>
```

Check the signatures on a key:

```bash
Command> check
uid  Bob (Executioner) <bob@cyb.org>
sig!       9E98BC16 1999-06-04   [self-signature]
sig!       BB7576AC 1999-06-04   Alice (Judge) <alice@cyb.org>
```

## Encrypting and decrypting documents

Alice encrypts with Bobs public key:

```bash
$ gpg --output doc.gpg --encrypt --recipient bob@cyb.org doc
```

Bob decrypts file sent by Alice:

```bash
$ gpg --output doc --decrypt doc.gpg

You need a passphrase to unlock the secret key for
user: "Bob (Executioner) <bob@cyb.org>"
1024-bit ELG-E key, ID 5C8CBD41, created 1999-06-04 (main key ID 9E98BC16)

Enter passphrase:
```

### Symmetric encryption

```bash
$ gpg --output doc.gpg --symmetric doc

Enter passphrase:
```

## Sign and verify documents

Documents are compressed before signed.

Sign:

```bash
$ gpg --output doc.sig --sign doc

You need a passphrase to unlock the private key for
user: "Alice (Judge) <alice@cyb.org>"
1024-bit DSA key, ID BB7576AC, created 1999-06-04

Enter passphrase:
```

Verify:

```bash
$ gpg --output doc --decrypt doc.sig

gpg: Signature made Fri Jun  4 12:02:38 1999 CDT using DSA key ID BB7576AC
gpg: Good signature from "Alice (Judge) <alice@cyb.org>"
```

### Clearsigned documents

Document wrapped in ASCII-armored signature.

```bash
$ gpg --clearsign documents

You need a passphrase to unlock the secret key for
user: "Alice (Judge) <alice@cyb.org>"
1024-bit DSA key, ID BB7576AC, created 1999-06-04

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[...]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v0.9.7 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjdYCQoACgkQJ9S6ULt1dqz6IwCfQ7wP6i/i8HhbcOSKF4ELyQB1
oCoAoOuqpRqEzr4kOkQqHRLE/b8/Rw2k
=y6kj
-----END PGP SIGNATURE-----
```

### Detached signatures

Detaches signature of the document:

```bash
$ gpg --output doc.sig --detach-sig doc

You need a passphrase to unlock the secret key for
user: "Alice (Judge) <alice@cyb.org>"
1024-bit DSA key, ID BB7576AC, created 1999-06-04

Enter passphrase
```

Verification:

```bash
$ gpg --verify doc.sig doc

gpg: Signature made Fri Jun  4 12:38:46 1999 CDT using DSA key ID BB7576AC
gpg: Good signature from "Alice (Judge) <alice@cyb.org>"
```
