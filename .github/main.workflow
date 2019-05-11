workflow "New workflow" {
  on = "push"
  resolves = ["Mirror Action"]
}

action "Mirror Action" {
  uses = "./"
  secrets = ["GIT_USERNAME", "GIT_PASSWORD"]
  args = "https://gitlab.com/spyoungtech/mirror-action.git"
}
