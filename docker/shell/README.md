# ssmiller25/shell Container

A "starting point" container for an interactive shell.  Molyst 

## Running

Based on passing docker control directly to this contianer <https://fredrikaverpil.github.io/2018/12/14/control-docker-containers-from-within-container/>

```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock \
           -ti ssmiller25/shell
```