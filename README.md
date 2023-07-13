# ace-non-application-flows
Examples of ACE flows outside applications

```
mqsicreatebar -data ~/github.com/ace-non-application-flows -b /tmp/cb-test.bar -cleanBuild -o TopLevelFlows/TestFlow.msgflow
```
will fail because the subflows projects cannot be found.

```
mqsicreatebar -data $PWD -b /tmp/cb-test.bar -cleanBuild -p TopLevelFlows Subflows -o TopLevelFlows/TestFlow.msgflow  -l SubflowStaticLib
```
will succeed because the correct projects are specified on the command line.

Note that running the first command on a toolkit-created workspace (As opposed to a clone of this repo) will
work without errors; deleting the .metadata directory from such a workspace will stop it working.
