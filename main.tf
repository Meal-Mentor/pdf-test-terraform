terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "3.2.0"
    }
  }
}


resource "heroku_app" "default" {
  name   = "hh-pdf-test"
  region = "us"

  buildpacks = [
    "heroku/python",
    "heroku/nodejs"
  ]
}

resource "heroku_build" "main" {
  app = "${heroku_app.default.id}"

  source = {
    url = "https://github.com/Meal-Mentor/pdf-test/archive/main.tar.gz"
  }
  
}

resource "heroku_formation" "app_settings" {
  app        = "${heroku_app.default.id}"
  type       = "web"
  quantity   = 1
  size       = "free"
  depends_on = ["heroku_build.main"]
}