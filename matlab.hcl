job "matlab" {  
  datacenters = ["dc1"]
  type = "batch"
  parameterized {
    payload       = "optional"
    meta_required = ["FullCmd2Run"]
    meta_optional = ["Cmd", "Path", "CreatedBy", "RAM"]
  }

  group "matlab" {
    task "matlab" {
      driver = "raw_exec"

      config {
        command = "matlab"
        args = ["-batch", "${NOMAD_META_FULLCMD2RUN}"]
      }

    }
  }
}