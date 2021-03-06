DATE=`date '+%Y-%m-%d--%H.%M.%S'`
filename="backup-$DATE.tar.gz"
cd / # THIS CD IS IMPORTANT THE FOLLOWING LONG COMMAND IS RUN FROM /
tar -cvpzf $filename \
	--exclude=/$filename \
	--exclude=/proc \
	--exclude=/tmp \
	--exclude=/mnt \
	--exclude=/dev \
	--exclude=/sys \
	--exclude=/run \
	--exclude=/media \
	--exclude=/var/log \
	--exclude=/var/cache/apt/archives \
	--exclude=/usr/src/linux-headers* \
	--exclude=/home/*/.gvfs \
	--exclude=/home/*/VirtualBox* \
	--exclude=/home/*/.cache \
	--exclude=/home/*/.local/share/Trash /
