job "nginx" {
  datacenters = ["dc1"]
  type = "service"

  group "nginx" {
    count = 2

    network {
      port "http" {}
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "nginx:alpine"
        ports = ["http"]
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}
