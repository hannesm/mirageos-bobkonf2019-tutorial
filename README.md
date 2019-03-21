# MirageOS tutorial at bobkonf 2019

[![Build Status](https://travis-ci.org/hannesm/mirageos-bobkonf2019-tutorial.svg?branch=master)](https://travis-ci.org/hannesm/mirageos-bobkonf2019-tutorial)

In this repository are some example unikernels, used as tutorial introduction
at Bobkonf 2019.

The only real prerequisite is [opam](https://opam.ocaml.org) >= 2.0.0. Any macOS
or Linux/BSD system should be fine.

To get started, install first some OCaml tools:

```bash
$ opam version
2.0.0 (or higher)
$ opam init
$ opam update
$ opam switch create 4.07.1
..takes some time, compiles OCaml..
$ eval `opam env` # set's environment variables, need to be repeated in every new shell (.shrc is your friend)!
$ opam install merlin ocp-indent mirage utop
merlin instructions (setting up emacs, vim, etc.)
$ mirage --version
3.5.0 (at least)
```

Now, we're ready to get started with the first example in 00-hello! :)

```bash
$ mirage configure --help #outputs configure man page
$ mirage configure #configures the unikernel for unix
$ make depend #installs opam dependencies
$ mirage build #or make, compiles the unikernel
$ ./main.native
```

For the hypervisor

```bash
$ mirage configure -t hvt && make depend && mirage build
#configures the same unikernel for hvt (kvm)
#compiles the unikernel. providing solo5-hvt and hello.hvt
$ ./solo5-hvt hello.hvt #executes the unikernel as virtual machine
```

Command-line arguments

```bash
$ ./solo5-hvt hello.hvt -l \*:debug
$ ./solo5-hvt --net=tap0 dns_client.hvt --ipv4=10.0.42.5/24 --ipv4-gateway=10.0.42.1 -l debug
$ ./solo5-hvt --mem=16 --net=tap0 dns_client.hvt --help
$ ./solo5-hvt --mem=16 --net=tap0 dns_client.hvt --ipv4=10.0.42.5/24 --ipv4-gateway=10.0.42.1 --hostname=example.com
```
