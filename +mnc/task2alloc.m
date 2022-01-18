function alloc_id = task2alloc(task_id)
response = webread([mnc.config('nomad_url') '/job/' task_id '/allocations']);
alloc_id = response.ID;
end

