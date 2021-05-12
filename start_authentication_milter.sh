#!/bin/bash

rm -f /run/.*pid
rsyslogd
exec authentication_milter
