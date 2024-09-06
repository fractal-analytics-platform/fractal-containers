#!/bin/sh

openrc default                 #set runlevel to default
rc-update add monitord default # add monitord service to system services
service monitord start

/filebrowser
