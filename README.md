# mirror-action
A GitHub Action for mirroring your commits to a different remote repository

This project is [mirrored on GitLab](https://gitlab.com/spyoungtech/mirror-action)

## Example workflows

### Mirror a repository with username/password over HTTPS

For example, this project uses the following workflow to mirror from GitHub to GitLab

```yaml
on: [push]
  ...
      steps:
        - uses: actions/checkout@v1
        - uses: spyoungtech/mirror-action@master
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

Pretty much the same, but use `GIT_SSH_PRIVATE_KEY`

```yaml
      steps:
        - uses: actions/checkout@v1
        - uses: spyoungtech/mirror-action@master
          with:
            REMOTE: 'https://gitlab.com/spyoungtech/mirror-action.git'
            GIT_USERNAME: spyoungtech
            GIT_SSH_PRIVATE_KEY: ${{ secrets.GIT_SSH_KEY }}

```
Be sure you set the `GIT_SSH_KEY` in your repo secrets settings.
