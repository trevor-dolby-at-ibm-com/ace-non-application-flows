# ace-non-application-flows
Examples of ACE flows outside applications

Uses the [ace-full](https://github.com/ot4i/ace-docker/tree/main/experimental/ace-full) image to
run mqsicreatebar, which allows the building of non-application resources. The `ibmint` command 
can be run from much smaller images, but is not intended to handle non-application (top-level)
flows. 

See the [GitHub Action YAML](.github/workflows/main.yml) definition for details.

## Instructions

```
mqsicreatebar -data ~/github.com/ace-non-application-flows -b /tmp/cb-test.bar -cleanBuild -o TopLevelFlows/TestFlow.msgflow
```
will fail because the subflows projects cannot be found.

```
mqsicreatebar -data $PWD -b /tmp/cb-test.bar -cleanBuild -p TopLevelFlows Subflows -o TopLevelFlows/TestFlow.msgflow  -l SubflowStaticLib
```
will succeed because the correct projects are specified on the command line.

Note that running the first command on a toolkit-created workspace (as opposed to a clone of this repo) will
work without errors; deleting the .metadata directory from such a workspace will stop it working.

## Notes on testing

The JUnit tests rely on the non-application flows being moved to the default application
before the test projects are run. This happens on IntegrationServer startup before the tests
are run, but the name used in the test when constructing the SpyObjectReference must match
the default application name given to the server on startup.

While the tests run successfully in the server, running the tests from the toolkit is 
complicated by the BAR generator not pulling in the flows when populating the work 
directory: only application and libraries are included by the BAR generator. This could
be solved by prepopulating a work directory with the flows and then using that work
directory to run the tests.

See the build-and-ut scripts for information on how the tests are run.
