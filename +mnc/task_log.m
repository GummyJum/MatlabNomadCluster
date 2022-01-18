function result = task_log(task_id, type)
if ~exist('type', 'var')
    type = 'stdout';
end
alloc_id = mnc.task2alloc(task_id);
result = webread([mnc.config('nomad_url') '/client/fs/logs/' alloc_id], 'task', 'matlab', 'type', type, 'plain', 'true');
end

