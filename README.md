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
>> url = 'http://localhost:4646/v1/job/matlab/dispatch';
>> script_to_run = 'disp hey';
>> data = struct();
>> data.Payload = matlab.net.base64encode(script_to_run);
>> data.Meta = struct();
>> response = webwrite(url, data)
response = 
  struct with fields:
    DispatchedJobID: 'matlab/dispatch-1642501729-283d38c4'
             EvalID: '0db6a76e-6b2e-b011-e11f-1d6c0b108661'
    EvalCreateIndex: 35
     JobCreateIndex: 34
              Index: 35
```

You can see the the job progress and logs in the nomad-ui at http://localhost:4646/ui/jobs/matlab
or query the job status using the cli:

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

And retrieve the allocation logs accoardingly:

```
$ nomad alloc logs aad9e77a
hey
```