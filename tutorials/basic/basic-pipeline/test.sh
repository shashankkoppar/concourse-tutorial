
#!/bin/bash

set -eu

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export fly_target=${fly_target:-tutorial}
echo "Concourse API target ${fly_target}"
echo "Tutorial $(basename $DIR)"

pushd $DIR
  fly-3.14.1 -t ${fly_target} set-pipeline -p tutorial-pipeline -c pipeline.yml -n
  fly-3.14.1 -t ${fly_target} unpause-pipeline -p tutorial-pipeline
  fly-3.14.1 -t ${fly_target} trigger-job -w -j tutorial-pipeline/job-hello-world
popd
