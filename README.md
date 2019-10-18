# simple-build-mon

### Objective:
#### Alert a slack channel with the status of a Bamboo build job.

### Setup:
1. In Bamboo, navigate to the desired plan and enter the configuration view.
2. Add the repository holding the scripts/slack payload (here, https://github.com/s1dequest/simple-build-mon).
3. Select the desired build stage.
4. Add task: checkout the source repository we just added.
    * Note: Add this task **after** the other tasks you'd like to monitor.
    * This will add the slack_payload.json file to the build directory.
5. Add task: of type 'script'.
    * Title it whatever, but something self-explanatory is good. We will title our 'If Success - Create File'.
    * Add the code from `build-mon-v2-create-file-sh`.
6. Add **FINAL** task: of type 'script'.
    * Title 'Slack Alert - Check for Success File'
    * Add the code from `build-mon-v2-check-file.sh`.

#### Basic Idea
* This setup will allow for alerting build status to our slack channel in a simple/lightweight way.
* Essentially, if the tasks being performed prior to our `If Success - Create File` script exit with code != 0, the file will not be created, as the script task will not run. The 'Final' task we added to the script will run regardless of the status of the other tasks, and thus will be able to send the slack alert regardless of if all prior tasks have been performed.

