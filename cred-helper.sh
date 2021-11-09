#!/usr/bin/env  bash

GIT_PASSWORD=${INPUT_GIT_PASSWORD:-${GIT_PASSWORD}}
exec echo "$GIT_PASSWORD"
