# Drift canary for the tfecli drift agent.
#
# Manages one file (canary.txt) on the drift-canary branch of the sandbox repo.
# To cause drift, edit canary.txt on GitHub (drift-canary.sh drift does this).
# The next plan wants to put the content back; the agent should update the
# content below to match and open a PR.
#
# Auth: the provider reads GITHUB_OWNER, GITHUB_APP_ID,
# GITHUB_APP_INSTALLATION_ID and GITHUB_APP_PEM_FILE from workspace env vars.

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  app_auth {}
}

resource "github_branch" "canary" {
  repository = "tfecli-drift-agent-sandbox"
  branch     = "drift-canary"
}

resource "github_repository_file" "canary" {
  repository          = "tfecli-drift-agent-sandbox"
  branch              = github_branch.canary.branch
  file                = "canary.txt"
  content             = "drifted by hand at 2026-10-20T21:07:52Z\n"
  commit_message      = "canary: managed by terraform"
  overwrite_on_create = true
}
