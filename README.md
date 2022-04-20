# mirror-action
A GitHub Action for mirroring your commits to a different remote repository

This project is [mirrored on GitLab](https://gitlab.com/yesolutions/mirror-action)

## Example workflows

### Mirror a repository with username/password over HTTPS

For example, this project uses the following workflow to mirror from GitHub to GitLab

```yaml
on: [push]
  ...
      steps:
        - uses: actions/checkout@v3
          with:
            fetch-depth: 0
        - uses: yesolutions/mirror-action@master
          with:
            REMOTE: 'https://gitlab.com/spyoungtech/mirror-action.git'
            GIT_USERNAME: spyoungtech
            GIT_PASSWORD: ${{ secrets.GIT_PASSWORD }}
```

Be sure to set the `GIT_PASSWORD` secret in your repo secrets settings.


**NOTE:** by default, all branches are pushed. If you want to avoid
this behavior, set `PUSH_ALL_REFS: "false"`

You can further customize the push behavior with the `GIT_PUSH_ARGS` parameter.
By default, this is set to `--tags --force --prune`

If something goes wrong, you can debug by setting `DEBUG: "true"`

### Mirror a repository using SSH

Requires version 0.4.0+

Pretty much the same, but using `GIT_SSH_PRIVATE_KEY` and `GIT_SSH_KNOWN_HOSTS`

```yaml
      steps:
        - uses: actions/checkout@v3
          with:
            fetch-depth: 0
        - uses: yesolutions/mirror-action@master
          with:
            REMOTE: 'ssh://git@gitlab.com/spyoungtech/mirror-action.git'
            GIT_SSH_PRIVATE_KEY: ${{ secrets.GIT_SSH_PRIVATE_KEY }}
            GIT_SSH_KNOWN_HOSTS: ${{ secrets.GIT_SSH_KNOWN_HOSTS }}

```

`GIT_SSH_KNOWN_HOSTS` is expected to be the contents of a `known_hosts` file.

Be sure you set the secrets in your repo secrets settings!

**NOTE:** if you prefer to skip hosts verification instead of providing a known_hosts file,
you can do so by using the `GIT_SSH_NO_VERIFY_HOST` input option. e.g.

```yaml
      steps:
        - uses: actions/checkout@v3
          with:
            fetch-depth: 0
        - uses: yesolutions/mirror-action@master
          with:
            REMOTE: git@gitlab.com/spyoungtech/mirror-action.git
            GIT_SSH_PRIVATE_KEY: ${{ secrets.GIT_SSH_PRIVATE_KEY }}
            GIT_SSH_NO_VERIFY_HOST: "true"
```

WARNING: this setting is a compromise in security. Using known hosts is recommended.
