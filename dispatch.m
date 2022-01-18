url = 'http://localhost:4646/v1/job/matlab/dispatch';
script_to_run = 'disp hey';
data = struct();
data.Payload = matlab.net.base64encode(script_to_run);
data.Meta = struct();
responseData = webwrite(url, data);
disp(responseData);