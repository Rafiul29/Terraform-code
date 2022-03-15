


resource "github_repository" "terraform-first-repo2" {
  name        = "first-repo-form-terraform2"
  description = "My awesome codebase"

  visibility = "public"

  auto_init = true

}


resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-form-terraform2"
  description = "My awesome codebase"

  visibility = "public"

  auto_init = true

}