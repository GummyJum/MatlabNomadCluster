function task_id = new_task(cmd)
url = [mnc.config('nomad_url') '/job/matlab/dispatch'];
data.Payload = matlab.net.base64encode(cmd);
data.Meta = struct();
response = webwrite(url, data);
task_id = response.DispatchedJobID;
end
% disp(response);
% !nomad job status matlab/dispatch-1642507567-ec7c03e1
% !nomad alloc logs 6a7e1872