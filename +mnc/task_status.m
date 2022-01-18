function status = task_status(task_id)
if ~exist('task_id', 'var')
    status = struct2table(webread([mnc.config('nomad_url') '/jobs']));
else
    status = webread([mnc.config('nomad_url') '/job/' task_id]);
end

end
