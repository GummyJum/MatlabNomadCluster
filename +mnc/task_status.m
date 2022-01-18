function status = task_status(task_id)
status = webread([mnc.config('nomad_url') '/job/' task_id]);
end

