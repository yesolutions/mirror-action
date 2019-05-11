# mirror-action
A GitHub Action for mirroring your repository to a different remote repository

This project is [mirrored on GitLab](https://gitlab.com/spyoungtech/mirror-action)

## Example workflow

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