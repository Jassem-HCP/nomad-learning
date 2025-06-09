job "hello-world" {
  datacenters = ["dc1"]
  type = "batch"
  group "example" {
    count = 10 # Try changing this to 1, 3, or more to scale

    task "hello" {
      driver = "docker"

      config {
        image = "busybox"
        args  = ["echo", "Hello from Nomad!"]
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}
