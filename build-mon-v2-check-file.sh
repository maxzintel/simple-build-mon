#!/bin/bash

pwd
if [[ -f ${bamboo.planName}-${bamboo.buildNumber}-success.txt) ]];
  then
    echo "Build Monitor confirmed a SUCCESSFUL run!"
    # Slack Hook Here
    cat slack_payload.json | jq -cr ".text = \"*<https://<your-bamboo-url>/browse/${bamboo.planName}|Build Successful>*\"" | jq -cr ".attachments[0].blocks[0].text.text = \"*Build Plan:* ${bamboo.planName} \n *Agent:* ${bamboo.agentId}\n *Build Number:* ${bamboo.buildNumber} \"" | jq -c . > slack.json
    curl -X POST -H 'Content-type: application/json' --data '@slack.json' https://hooks.slack.com/services/<your-slack-hook>
    echo "SLACK ALERT HAS BEEN SENT FOR SUCCESSFUL RUN"
  else
    echo "Uh oh, Build Monitor caught a FAILED test run!"
    # Slack Hook Here
    cat slack_payload.json | jq -cr ".icon_emoji = \":x:\"" | jq -cr ".text = \"*<https://<your-bamboo-url>/browse/${bamboo.planName}|Build FAILED>*\"" | jq -cr ".attachments[0].color = \"#fe0000\" " | jq -cr ".attachments[0].blocks[0].text.text = \"*Build Plan:* ${bamboo.planName} \n *Agent:* ${bamboo.agentId}\n *Build Number:* ${bamboo.buildNumber} \"" | jq -c . > slack.json
    curl -X POST -H 'Content-type: application/json' --data '@slack.json' https://hooks.slack.com/services/<your-slack-hook>
    echo "SLACK ALERT HAS BEEN SENT FOR FAILED RUN"
fi
