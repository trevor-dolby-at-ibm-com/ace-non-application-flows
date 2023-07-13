# ace-non-application-flows
Examples of ACE flows outside applications

```
mqsicreatebar -data ~/github.com/ace-non-application-flows -b /tmp/cb-test.bar -cleanBuild -o TopLevelFlows/TestFlow.msgflow
```
will fail because the subflows project cannot be found.

```
mqsicreatebar -data $PWD -b /tmp/cb-test.bar -cleanBuild -p TopLevelFlows Subflows -o TopLevelFlows/TestFlow.msgflow 
```
will succeed because the correct projects are specified on the command line.
