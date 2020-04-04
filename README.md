# mirror-action
A GitHub Action for mirroring your commits to a different remote repository

This project is [mirrored on GitLab](https://gitlab.com/spyoungtech/mirror-action)

## Example workflows

### Mirror a repository with username/password over HTTPS

For example, this project uses the following workflow to mirror from GitHub to GitLab

```workflow
workflow "Mirror Workflow" {
  on = "push"
  resolves = ["Mirror Action"]
}

action "Mirror Action" {
  uses = "spyoungtech/mirror-action@master"
  secrets = ["GIT_PASSWORD"]
  args = "https://gitlab.com/spyoungtech/mirror-action.git"
  env = {
    GIT_USERNAME = "spyoungtech"
  }
}
```

YAML version 

```yaml
on: [push]
  ...
      steps:
        - uses: spyoungtech/mirror-action@master
          env:
            GIT_USERNAME: spyoungtech
            GIT_PASSWORD: ${{ secrets.GIT_PASSWORD }}
            SRC_REPO: https://github.com/${{ github.repository }}
          with:
            args: 'https://gitlab.com/spyoungtech/mirror-action.git'
```



Be sure to set the `GIT_PASSWORD` secret in the Actions editor.

### Mirror a repository using SSH

*Coming soon*

