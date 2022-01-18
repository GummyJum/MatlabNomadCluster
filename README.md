# MatlabNomadCluster

## Example
First start a standalone nomad agent:
```
$ nomad agent -dev -bind 0.0.0.0 -log-level INFO
...
```

Then from another console:
```
$ nomad job plan matlab.hcl
...
$ nomad job run matlab.hcl
...
```

Then use matlab to dispatch some job, for example:
```matlab
url = 'http://localhost:4646/v1/job/matlab/dispatch';
script_to_run = 'disp hey';
data = struct();
data.Payload = matlab.net.base64encode(script_to_run);
data.Meta = struct();
responseData = webwrite(url, data);
disp(responseData); 
```

Then you can see the logs in the nomad-ui at http://localhost:4646/ui/jobs/matlab
or you can query using the cli:

```
$ nomad job status matlab/dispatch-1642501729-283d38c4
ID            = matlab/dispatch-1642501729-283d38c4
Name          = matlab/dispatch-1642501729-283d38c4
Submit Date   = 2022-01-18T12:28:49+02:00
Type          = batch
Priority      = 50
Datacenters   = dc1
Namespace     = default
Status        = dead
Periodic      = false
Parameterized = false

Summary
Task Group  Queued  Starting  Running  Failed  Complete  Lost
matlab      0       0         0        0       1         0

Allocations
ID        Node ID   Task Group  Version  Desired  Status    Created    Modified
aad9e77a  5b7cbc65  matlab      1        run      complete  3m21s ago  3m16s ago
```

And retrive the allocation logs accoardingly:

```
$ nomad alloc logs aad9e77a
hey
```