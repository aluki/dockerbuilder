# Dockerbuilder

Dockerbuilder should be added as a submodule to the desired dockerfile project. 


```
git submodule add git@github.com:lookiero/dockerbuilder.git dockerbuilder
```
A symbolic link to Makefile is also needed: 
```
ln -s dockerbuilder/Makefile Makefile
```

Once created, info.yaml file should be created. This file will contain the following variables: 

```
from_image:  (base image)
from_version: (base image version)
image: (image to create)
version: (version to create)
``` 
This variables should be used on the dockerfile itself
```
ARG FROM_IMAGE
ARG FROM_VERSION

FROM ${FROM_IMAGE}:${FROM_VERSION} 
```


### Use
make -> Build and tag the dockerfile locally

make push -> push the image to registry
