# Pass

## Init

```bash
$ pass init <gpg-id or email>
```

## Create new password

```bash
$ pass insert github.com/ibihim/repository
```

## View stored passwords

```bash
$ pass

Password Store
└── github.com
    └── ibihim
        └── repository
```

## Generate random password of size n

```bash
$ pass generate github.com/ibihim/repository n
```

## Retrieve password

```bash
$ pass github.com/ibihim/repository
```

With `xclip`.
```bash
$ pass -c github.com/ibihim/repository
```

## Some menu fancy stuff

```bash
passmenu
```

