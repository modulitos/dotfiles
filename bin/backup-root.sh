#!/bin/bash

# -S is added to more efficiently handle Docker images
sudo rsync -SaAXvx --info=progress2 --delete -H / /run/media/lucas/root-backup/

