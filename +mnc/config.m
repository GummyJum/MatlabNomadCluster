function output = config(field_name)

conf.nomad_url = 'http://localhost:4646/v1';
output = conf.(field_name);
end

