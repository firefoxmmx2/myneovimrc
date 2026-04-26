#!/bin/bash
awk '{d=int($1/86400);h=int($1%86400/3600);m=int($1%3600/60);r="";if(d)r=r d"d ";if(h)r=r h"h ";print r m"m"}' /proc/uptime
