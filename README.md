# Docker image for alinode

What is alinode?

Please see [this](http://alinode.aliyun.com)

## Version

- `latest` now is 3.11.0
- `3` now is 3.11.0
- `2` now is 2.5.0
- `1` now is 1.10.0

[Version Map With Office Node.js](http://alinode.aliyun.com/doc/alinode_versions)

## ENV

- `ALINODE_APP_ID` default is ''
- `ALINODE_APP_SECRET` default is ''
- `NODE_LOG_DIR` default is '/etc/log/alinode'
- `ALINODE_CONFIG` default is '/etc/agentx.json'

## Run

```bash
docker run -d -e ALINODE_APP_ID=xxx -e ALINODE_APP_SECRET=yyy --name alinode xgheaven/alinode
```

if `ALINODE_APP_ID` and `ALINODE_APP_SECRET` are empty. AgentX do not start. Running like normal nodejs project.

## Build

Run `rake build_dockerfile`. Take a coffee, auto build in cloud.
