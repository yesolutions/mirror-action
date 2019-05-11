# mirror-action
A GitHub Action for mirroring your repository to a different remote repository

This project is [mirrored on GitLab](https://gitlab.com/spyoungtech/mirror-action)

## Example workflows

### Mirror a repository with username/password over HTTPS

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

Be sure to set the `GIT_PASSWORD` secret in the Actions editor.

### Mirror a repository using SSH

*Coming soon*

