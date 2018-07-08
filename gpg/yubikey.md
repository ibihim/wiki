# Yubikey / GPG

## Goal

Put the master key on an usb and use subkey on the YubiKey.

## Advantage

Putting the master key offline makes it safe as the master key is the "identity". Losing is katastrophal and compromises established identity. If subkey is compromised, it is revokable and identity still intact.
Private key is very safe on YubiKey. Secured with passphrase and YubiKey PIN.

## Setup

Idealy performed on an offline PC with an USB Stick inserted:

```bash
$ export GNUPGHOME=/media/usb-stick/gnupghome
$ mkdir $GNUPGHOME
```

### Generating the master key

Goal is to create a master key without any subkeys.

```bash
$ gpg --expert --gen-key

gpg (GnuPG) 2.0.30; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

gpg: directory `/media/usb-stick/gnupghome' created
gpg: new configuration file `/media/usb-stick/gnupghome/gpg.conf' created
gpg: WARNING: options in `/media/usb-stick/gnupghome/gpg.conf' are not yet active during this run
gpg: keyring `/media/usb-stick/gnupghome/secring.gpg' created
gpg: keyring `/media/usb-stick/gnupghome/pubring.gpg' created
Please select what kind of key you want:
(1) RSA and RSA (default)
(2) DSA and Elgamal
(3) DSA (sign only)
(4) RSA (sign only)
(7) DSA (set your own capabilities)
(8) RSA (set your own capabilities)
Your selection? 8

Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Sign Certify Encrypt

(S) Toggle the sign capability
(E) Toggle the encrypt capability
(A) Toggle the authenticate capability
(Q) Finished

Your selection? s

Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Certify Encrypt

(S) Toggle the sign capability
(E) Toggle the encrypt capability
(A) Toggle the authenticate capability
(Q) Finished

Your selection? e

Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Certify

(S) Toggle the sign capability
(E) Toggle the encrypt capability
(A) Toggle the authenticate capability
(Q) Finished

Your selection? q
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
        0 = key does not expire
    <n>  = key expires in n days
    <n>w = key expires in n weeks
    <n>m = key expires in n months
    <n>y = key expires in n years
Key is valid for? (0) 2y
Key expires at Wed 25 Sep 18:39:49 2019 BST
Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: Krzysztof Ostrowski
Email address: user@email.com
Comment:
You selected this USER-ID:
    "Krzysztof Ostrowski <user@email.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o
You need a Passphrase to protect your secret key.

We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: /media/usb-stick/gnupghome/trustdb.gpg: trustdb created
gpg: key 2240402E marked as ultimately trusted
public and secret key created and signed.

gpg: checking the trustdb
gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: next trustdb check due at 2020-07-07
pub   4096R/2240402E 2018-07-07 [expires: 2020-07-07]
    Key fingerprint = 7D4C 4090 DB50 1693 4614  F6FC 6206 9DE9 2240 402E
uid       [ultimate] Krzysztof Ostrowski <user@email.com>
```

### Create a revocation certificate

```bash
$ gpg --gen-revoke 2240402E > 2240402E-revocation-certificate.asc

sec  4096R/2240402E 2018-07-07 Krzysztof Ostrowski <user@email.com>

Create a revocation certificate for this key? (y/N) y
Please select the reason for the revocation:
0 = No reason specified
1 = Key has been compromised
2 = Key is superseded
3 = Key is no longer used
Q = Cancel
(Probably you want to select 1 here)
Your decision? 3
Enter an optional description; end it with an empty line:
>
Reason for revocation: Key is no longer used
(No description given)
Is this okay? (y/N) y

You need a passphrase to unlock the secret key for
user: "Krzysztof Ostrowski <user@email.com>"
4096-bit RSA key, ID 2240402E, created 2018-07-07

ASCII armored output forced.
Revocation certificate created.

Please move it to a medium which you can hide away; if Mallory gets
access to this certificate he can use it to make your key unusable.
It is smart to print this certificate and store it away, just in case
your media become unreadable.  But have some caution:  The print system of
your machine might store the data and make it available to others!
```

### Create encryption subkey

```bash
$ gpg --edit-key 2240402E

gpg (GnuPG) 2.0.30; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

pub  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07  usage: C
                    trust: ultimate      validity: ultimate
[ultimate] (1). Krzysztof Ostrowski <user@email.com>

gpg> addkey
Key is protected.

You need a passphrase to unlock the secret key for
user: "Krzysztof Ostrowski <user@email.com>"
4096-bit RSA key, ID 2240402E, created 2018-07-07

Please select what kind of key you want:
(3) DSA (sign only)
(4) RSA (sign only)
(5) Elgamal (encrypt only)
(6) RSA (encrypt only)
Your selection? 6
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
        0 = key does not expire
    <n>  = key expires in n days
    <n>w = key expires in n weeks
    <n>m = key expires in n months
    <n>y = key expires in n years
Key is valid for? (0) 2y
Key expires at Wed 25 Sep 18:47:21 2019 BST
Is this correct? (y/N) y
Really create? (y/N) y
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

pub  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07  usage: C
                    trust: ultimate      validity: ultimate
sub  4096R/01731555  created: 2018-07-07  expires: 2020-07-07  usage: E
[ultimate] (1). Krzysztof Ostrowski <user@email.com>

gpg> save
```

### Backup the secret key

Includes master key and the subkey. You might want to add `--armor` (changes format).

```bash
$ gpg --export-secret-key 2240402E > 2240402E-secret.gpg
```

### Use the YubiKey

Authentication and encryption keys are created on the YubiKey.

If for what ever reason it does not work on Arch Linux with 4096 bit keys, use Ubuntu from USB.

```bash
$ gpg --edit-key 2240402E

gpg (GnuPG) 2.0.30; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

pub  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07  usage: C
                    trust: ultimate      validity: ultimate
sub  4096R/01731555  created: 2018-07-07  expires: 2020-07-07  usage: E
[ultimate] (1). Krzysztof Ostrowski <user@email.com>

gpg> addcardkey
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]

Please select the type of key to generate:
(1) Signature key
(2) Encryption key
(3) Authentication key
Your selection? 1

What keysize do you want for the Signature key? (4096)
Key is protected.

You need a passphrase to unlock the secret key for
user: "Krzysztof Ostrowski <user@email.com>"
4096-bit RSA key, ID 2240402E, created 2018-07-07

Please specify how long the key should be valid.
        0 = key does not expire
    <n>  = key expires in n days
    <n>w = key expires in n weeks
    <n>m = key expires in n months
    <n>y = key expires in n years
Key is valid for? (0) 2y
Key expires at Wed 25 Sep 18:50:42 2019 BST
Is this correct? (y/N) y
Really create? (y/N) y

pub  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07  usage: C
                    trust: ultimate      validity: ultimate
sub  4096R/01731555  created: 2018-07-07  expires: 2020-07-07  usage: E
sub  4096R/771B0554  created: 2018-07-07  expires: 2020-07-07  usage: S
[ultimate] (1). Krzysztof Ostrowski <user@email.com>

gpg> addcardkey
Signature key ....: 6FAB DC46 1847 3550 3769  2D32 0DE1 36B4 771B 0554
Encryption key....: [none]
Authentication key: [none]

Please select the type of key to generate:
(1) Signature key
(2) Encryption key
(3) Authentication key
Your selection? 3

What keysize do you want for the Authentication key? (4096)
Key is protected.

You need a passphrase to unlock the secret key for
user: "Krzysztof Ostrowski <user@email.com>"
4096-bit RSA key, ID 2240402E, created 2018-07-07

Please specify how long the key should be valid.
        0 = key does not expire
    <n>  = key expires in n days
    <n>w = key expires in n weeks
    <n>m = key expires in n months
    <n>y = key expires in n years
Key is valid for? (0) 2y
Key expires at Wed 25 Sep 18:54:51 2019 BST
Is this correct? (y/N) y
Really create? (y/N) y

pub  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07  usage: C
                    trust: ultimate      validity: ultimate
sub  4096R/01731555  created: 2018-07-07  expires: 2020-07-07  usage: E
sub  4096R/771B0554  created: 2018-07-07  expires: 2020-07-07  usage: S
sub  4096R/A9B5334C  created: 2018-07-07  expires: 2020-07-07  usage: A
[ultimate] (1). Krzysztof Ostrowski <user@email.com>

gpg> toggle

sec  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07
ssb  4096R/01731555  created: 2018-07-07  expires: never
ssb  4096R/771B0554  created: 2018-07-07  expires: 2020-07-07
                    card-no: 0006 05672181
ssb  4096R/A9B5334C  created: 2018-07-07  expires: 2020-07-07
                    card-no: 0006 05672181
(1)  Krzysztof Ostrowski <user@email.com>

gpg> key 1

sec  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07
ssb* 4096R/01731555  created: 2018-07-07  expires: never
ssb  4096R/771B0554  created: 2018-07-07  expires: 2020-07-07
                    card-no: 0006 05672181
ssb  4096R/A9B5334C  created: 2018-07-07  expires: 2020-07-07
                    card-no: 0006 05672181
(1)  Krzysztof Ostrowski <user@email.com>

gpg> keytocard
Signature key ....: 6FAB DC46 1847 3550 3769  2D32 0DE1 36B4 771B 0554
Encryption key....: [none]
Authentication key: BD26 3AD8 985E CAB0 9F32  7307 DF7C F7C0 A9B5 334C

Please select where to store the key:
(2) Encryption key
Your selection? 2

You need a passphrase to unlock the secret key for
user: "Krzysztof Ostrowski <user@email.com>"
4096-bit RSA key, ID 01731555, created 2018-07-07


sec  4096R/2240402E  created: 2018-07-07  expires: 2020-07-07
ssb* 4096R/01731555  created: 2018-07-07  expires: never
                    card-no: 0006 05672181
ssb  4096R/771B0554  created: 2018-07-07  expires: 2020-07-07
                    card-no: 0006 05672181
ssb  4096R/A9B5334C  created: 2018-07-07  expires: 2020-07-07
                    card-no: 0006 05672181
(1)  Krzysztof Ostrowski <user@email.com>

gpg> save
```
### Check keys

Expected: 1 pub key and 3 sub keys

```bash
gpg -k

/media/usb-stick/gnupghome/pubring.gpg
--------------------------------
pub   4096R/2240402E 2018-07-07 [expires: 2020-07-07]
uid       [ultimate] Krzysztof Ostrowski <user@email.com>
sub   4096R/01731555 2018-07-07 [expires: 2020-07-07]
sub   4096R/771B0554 2018-07-07 [expires: 2020-07-07]
sub   4096R/A9B5334C 2018-07-07 [expires: 2020-07-07]
```
Expected: 1 local key (marked as sec) and 3 other keys (marked as ssb>, the YubiKey ones)

```bash
$ gpg -K

/media/usb-stick/gnupghome/secring.gpg
--------------------------------
sec   4096R/2240402E 2018-07-07 [expires: 2020-07-07]
uid                  Krzysztof Ostrowski <user@email.com>
ssb>  4096R/01731555 2018-07-07
ssb>  4096R/771B0554 2018-07-07
ssb>  4096R/A9B5334C 2018-07-07
```

### Clean up

All keys should be secured on USB stick or YubiKey.

```bash
$ gpg --delete-secret-key 2240402E
```

### Export public key

Publish it :D This one is important.

Note: if you didn't create the master key, but are reusing your old one: the public key changed. It now contains your sub keys aswell. Please update your public key.

```bash
$ gpg --armor --export 2240402E > 2240402E.asc
```

### YubiKey configuration

Set user PIN, set admin PIN. Defaults:

 - user PIN: 123456
 - admin PIN: 12345678

Typing the user PIN 3 times wrong, forces you to use the admin PIN. If the admin PIN is typed 3 times wrong, you need to reset the YubiKey.

```bash
$ gpg --card-edit

Reader ...........: Yubico Yubikey 4 OTP U2F CCID
Application ID ...: D000000000000000000000000000000000
Version ..........: 2.1
Manufacturer .....: Yubico
Serial number ....: 012345678
Name of cardholder: [not set]
Language prefs ...: [not set]
Sex ..............: unspecified
URL of public key : [not set]
Login data .......: [not set]
Signature PIN ....: not forced
Key attributes ...: rsa4096 rsa4096 rsa4096
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 0 3
Signature counter : 3
Signature key ....: 6FAB DC46 1847 3550 3769  2D32 0DE1 36B4 771B 0554
    created ....: 2018-07-07 17:50:37
Encryption key....: FC6F 40BC 4173 8D13 2D7C  E958 BCDC EA84 0173 1555
    created ....: 2018-07-07 17:47:09
Authentication key: BD26 3AD8 985E CAB0 9F32  7307 DF7C F7C0 A9B5 334C
    created ....: 2018-07-07 17:54:49
General key info..: sub  rsa4096/0DE136B4771B0554 2018-07-07 Krzysztof Ostrowski <user@email.com>
sec#  rsa4096/62069DE92240402E  created: 2018-07-07  expires: 2020-07-07
ssb>  rsa4096/BCDCEA8401731555  created: 2018-07-07  expires: 2020-07-07
                                card-no: 0006 05672181
ssb>  rsa4096/0DE136B4771B0554  created: 2018-07-07  expires: 2020-07-07
                                card-no: 0006 05672181
ssb>  rsa4096/DF7CF7C0A9B5334C  created: 2018-07-07  expires: 2020-07-07
                                card-no: 0006 05672181

gpg/card> admin
Admin commands are allowed

# Change the PIN and Admin PINs
gpg/card> passwd
gpg: OpenPGP card no. D000000000000000000000000000000000 detected

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 1
PIN changed.

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 3
PIN changed.

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? q

# Make sure the PIN is entered before signing
gpg/card> forcesig

# Set the URL where the OpenPGP public key can be found.
gpg/card> url
URL to retrieve public key: https://keybase.io/2240402E.asc

# Fetch the public key into the local keyring
gpg/card> fetch

gpg/card> quit
```

Note: For use on any other compter, it is necessary to import at least the public key. If key is not read automatically, it might be fixed so:

```bash
$ gpg --card-status
```
