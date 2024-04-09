#!/bin/bash
#
# This script automates the building and testing of top-level flows.
#
# Copyright (c) 2024 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)
#

# Echo commands to the screen 
set -x

# Create the work directory
rm -rf /tmp/ace-non-application-flows-work-dir
mqsicreateworkdir /tmp/ace-non-application-flows-work-dir

# Build flows
mqsicreatebar -data . -b /tmp/non-application-flows.bar -cleanBuild -p TopLevelFlows Subflows -o TopLevelFlows/TestFlow.msgflow  -l SubflowStaticLib
mqsibar -c -w /tmp/ace-non-application-flows-work-dir -a /tmp/non-application-flows.bar

# Build tests - ibmint new for v12
ibmint deploy --input-path . --output-work-directory /tmp/ace-non-application-flows-work-dir --project TopLevelFlows_Test

# Run the server to run the tests
# Note these tests require a default application name that must match the one used in the test code
IntegrationServer -w /tmp/ace-non-application-flows-work-dir --default-application-name DefaultApplication --start-msgflows false --no-nodejs --admin-rest-api -1 --test-project TopLevelFlows_Test
