#!/bin/bash

if [ ! -d "$LOGFILE_DIR" ]; then
    #logmessage "Creating Logfile Folder ..."
    mkdir -p "$LOGFILE_DIR"
    if [ $? -eq 0 ]; then
        # not sure if i should set a message here
    else
        # not sure if i should set a message here
        exit 1
    fi
else
    # not sure if i should set a message here
fi

# Check if Logfile exists
if [ ! -f "$LOGFILE" ]; then
    # not sure if i should set a message here
    touch "$LOGFILE"
    if [ $? -eq 0 ]; then
        # not sure if i should set a message here
    else
        # not sure if i should set a message here
        exit 1
    fi
else
    # not sure if i should set a message here
fi
