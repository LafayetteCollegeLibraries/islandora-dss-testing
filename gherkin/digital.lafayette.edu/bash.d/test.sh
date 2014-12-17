#!/bin/bash

export NODE_PATH=node_modules:$NODE_PATH
bin/behat $@
