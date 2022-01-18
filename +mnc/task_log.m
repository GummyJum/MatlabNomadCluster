function status = task_log(task_id)
error('not yet implemented')
status = webread([mnc.config('nomad_url') '/job/' task_id]);
end

