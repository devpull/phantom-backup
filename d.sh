#!/usr/bin/env bash

sed -n 's/.*[ru|en]:\([0-9]*\).*/\1/p' cookie.txt > numid.txt