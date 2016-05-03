#!/bin/bash

# -S is added to more efficiently handle Docker images
# sudo does not affect the backup file ownership!
sudo rsync -SaAXvx --info=progress2 --delete -H /home/lucas /run/media/lucas/lucas-backup/

