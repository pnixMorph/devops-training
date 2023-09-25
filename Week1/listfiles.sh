directory=$1

if [[ ! -d $directory ]]; then
    echo "Directory does not exist"
    exit 1
fi


for filename in "$directory/*"; do
    head -n 1 $filename
done

exit 0
