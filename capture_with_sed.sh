#!/bin/bash

ios-deploy -c | grep Found | sed 's/^.*(//g'| sed 's/).*$//g' >
