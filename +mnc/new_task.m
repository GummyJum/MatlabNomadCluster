function task_ids = new_task(commands, varargin)
commands = reshape(commands,1,[]);
char_varargin = cellfun(@(x) char(x), varargin, 'UniformOutput', false);

tasks = cell(0);
if ~iscell(commands)
    commands = {commands};
end

if any(strcmpi('addpath', char_varargin))
    path2add = char_varargin{find(strcmpi('addpath', char_varargin), 1) + 1};
else
    path2add = '';
end

% if any(strcmpi('fail_policy', char_varargin))
%     fail_policy = char_varargin{find(strcmpi('fail_policy', char_varargin), 1) + 1};
% else
%     fail_policy = 'halt';
% end

for i = 1:length(commands)
    meta = [];
    command = char(commands{i});
    meta.CreatedBy = [getenv('COMPUTERNAME'), '/', getenv('USERNAME')];
    task_ids{i} = send_task_to_nomad(command, path2add, meta);
end


% if any(strcmpi('dependencies', char_varargin))
%     dependencies = varargin{find(strcmpi('dependencies', char_varargin), 1) + 1};
%     if ~iscell(dependencies)
%         dependencies = {dependencies};
%     end
% else
%     dependencies = {};
% end

if numel(task_ids) == 1
    task_ids = task_ids{1};
end
end

function task_id = send_task_to_nomad(cmd, path2add, meta)
meta.Cmd = cmd;
meta.Path = path2add;
meta.RAM = '0';
if ~isempty(path2add)
    cmd = ['addpath(' path2add '); ' cmd];
end
url = [mnc.config('nomad_url') '/job/matlab/dispatch'];
data.Payload = matlab.net.base64encode(cmd);
data.Meta = meta;
response = webwrite(url, data);
task_id = response.DispatchedJobID;
end
% disp(response);
% !nomad job status matlab/dispatch-1642507567-ec7c03e1
% !nomad alloc logs 6a7e1872