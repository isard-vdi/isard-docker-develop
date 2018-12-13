start_time="$(date -u +%s)"
docker-compose -f alpine.yml build --force
end_time="$(date -u +%s)"

elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for process"
