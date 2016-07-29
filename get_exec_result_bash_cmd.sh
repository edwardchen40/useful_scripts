bash -c "npm install && npm run lint"

if [ $? = 0 ]; then
	echo "SUCCESS"
    exit 0
else
	echo "FAILURE"
    say -r 130 -v Sin-ji "壞 壞 壞 壞 壞掉了 科科"
