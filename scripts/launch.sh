export CHDNSCHANGER="/opt/Chphisher"

if [[ $1 == '-h' || $1 == 'help' ]]; then
	echo "To run \`Chphisher\` type \`chphisher\` in your prompt"
	echo

else
	cd $CHDNSCHANGER
	python3 ./chphisher.py
fi
