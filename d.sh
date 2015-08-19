#!/usr/bin/env bash

sed -n 's/.*\(ru:[0-9]*\).*/\1/p' cookie.txt > some.txt