job "example-job" {
  datacenters = ["dc1"]
  type = "batch" 	

  group "example-group" {
    task "hello" {
      driver = "docker"

      config {
        image = "busybox"
        args  = ["echo", "Hello, Nomad!"]
	
      }
    }
  }
}
