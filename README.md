# Cubieserver - Jack's Homelab

:wave: Welcome to the Infrastructure as Code repository serving as the source of truth for Jack's Homelab - "Cubieserver". :house_with_garden: :desktop_computer:

> Note: the canonical repository is <https://git.cubieserver.de/Cubieserver/homelab>. The [Github mirror](https://github.com/jacksgt/homelab) is intended for disaster recovery purposes (to avoid the chicken-and-egg problem when bootstrapping the infrastructure).

The installation, setup and configuration of all software involved is handled by two components:

* **Ansible**: used for provisioning physical machines until they can join the Kubernetes cluster
* **Helm**: deploys all services on top of Kubernetes (specifically **Helmfile**)

An overview of the currently running services can be found on the [Cubieserver homepage](https://www.cubieserver.de).

In the past I also used various other setups for managing my systems:  Docker Swarm (circa 2017-2018), [Puppet (circa 2018-2021)](https://git.cubieserver.de/Cubieserver/puppet-control), [Flux](https://git.cubieserver.de/Cubieserver/homelab/src/branch/flux-old).

As with any good homelab setup, the setup keeps evolving and there are always some loose ends that need tying up.

## Selfhosted Applications

Lists of self-hosted services, applications and tools:

* <https://selfh.st/apps/>
* <https://yunohost.org/en/apps?q=%2Fapps>
* <https://fleet.linuxserver.io/>
* <https://github.com/awesome-selfhosted/awesome-selfhosted>

## License

This content is licensed under the MIT license.
Anything you find in this repository can be freely used, copied and redistributed for any purpose without asking for permission.

Copyright © 2025 Jack Henschel

```
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
