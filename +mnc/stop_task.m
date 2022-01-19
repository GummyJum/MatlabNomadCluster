function stop_task(task_id)
webwrite([mnc.config('nomad_url') '/job/' task_id], weboptions('RequestMethod','Delete'))
end

