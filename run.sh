#!/bin/bash
/home/mjs/toolbox/distcomp/bin/mdce start
/home/mjs/toolbox/distcomp/bin/startjobmanager -name xxx -remotehost mjs -v
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs -jobmanager xxx -remotehost node1 -v
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs -jobmanager xxx -remotehost node2 -v
