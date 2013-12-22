CentOS Builder
==============
This scripts uses [Packer](http://www.packer.io/) to build a CentOS base image with chef-solo and
Pupput enabled. 

Build a new box
```bash
packer build centos.json
```

Add the box to virtualbox
```bash
vagrant box add centos-6_5-64 centos-6_5-64.box
```
