job "matlab" {  
  datacenters = ["dc1"]
  type = "batch"
  parameterized {
    payload       = "required"
    meta_required = []
    meta_optional = ["Cmd", "Path", "CreatedBy", "RAM"]
  }

  group "matlab" {
    task "matlab" {
      driver = "raw_exec"

      config {
        command = "matlab"
        args = ["-batch", "run('${NOMAD_TASK_DIR}/task.m');"]
      }

      dispatch_payload {
        file = "task.m"
      }
    }
  }
}