# Overview

When working with resource management solutions, like kubernetes, mesos or swarm, often it is necessary to use a container as a "bridge" for getting into the cluster, and investigate a problem.

`fabriziopandini/pause` is minimal container that hangs waiting for SIGTERM, thus allowing to use `kubectl exec` or `docker exec` into the container.

The container exists in many variants:

- `:latest`, `:latest-alpine`, `:latest-alpine-dev`  
- `:latest-centos`
- `:latest-debian`
- `:latest-ubuntu`

Also a `:latest-scratch` is provided, allowing to create tiny container placeholders, but without the capability of running a bash into it. This can be used for instance for creating "dummy" sidecar containers in pods.