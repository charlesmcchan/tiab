# Trellis in a Box

Trellis in a Box (TiaB) is a container-based emulated environment.
It helps spinning up a Trellis test environment, which is perfect for beginners who want to get some quick hands on experience.

TiaB consists of two containers: ONOS and Mininet.
The script will automatically start a single instance ONOS, push corresponding network config, and connect Mininet environment to the controller.

## Prerequisite
We assume you have Docker installed in your system. We recommend using Docker >= 18.06.
For Docker on Mac users, remember to add `tiab/volume/onos` to shared folder list.

## Quick Start

- Download TiaB
    ```
    git clone https://github.com/charlesmcchan/tiab
    cd tiab
    ```

- Start TiaB
    ```
    make
    ```

- Attach to ONOS CLI
    ```
    make onos
    ```
    Note: default ONOS username/password is `onos/rocks`

- Attach to Mininet CLI
    ```
    make mininet
    ```

    Note: Mininet may still be starting. Wait until you see the `mininet>` prompt

    Caution: Ctrl-D will terminate mininet. Use Ctrl-P then Ctrl-Q to escape

- Attach to a host in Mininet
    ```
    make host HOST=h1
    ```

- Tear down TiaB
    ```
    make clean
    ```

## Things to Try

### Verify Connectivity (from Mininet CLI)

- Intra-rack ping (bridging)
    ```
    h1 ping 10.0.2.2
    ```

- Inter-rack ping (routing)
    ```
    h1 ping 10.0.3.2
    ```

- Ping a host behind upstream router
    ```
    h1 ping 10.0.99.2
    ```

## Advanced Options

- Topology

    By default, `make` command will spin up `trellis` topology, which is a simple 2x2 leaf-spine. There are a 7 options supported:
    - `trellis`: simple 2x2 leaf-spine. This is the **simplest topology**
    - `trellis_vlan`: with VLAN tagged hosts
    - `trellis_dualhome`: with dual-homed hosts
    - `trellis_duallink`: with dual-link between leaf and spine
    - `trellis_remote_dhcp`: with remote DHCP server
    - `trellis_hag`: multiple stage fabric. This is the **most complete topology**

    **To use another topology, search for an environment variable `TOPO` in `docker-compose.yaml` and replace it with desired value.**

    There are another 3 that requires BMV2, and therefore does **not** work in this environment.
    - `trellis_hybrid`
    - `trellis_hybrid_v4`
    - `trellis_p4`

    Double VLAN pop and route is no longer supported with OVS. We have moved forward to implementing that with P4 BNG. Therefore the follow one doesn't work either.
    - `trellis_double_tagged`

## Reference
- [1] [Trellis documentation](https://docs.trellisfabric.org)
- [2] [Trellis topology and netcfg examples](https://github.com/opennetworkinglab/routing/tree/master/trellis)
- [3] [Dockerfile of ONOS](https://github.com/opennetworkinglab/onos/blob/master/Dockerfile)
- [4] [Dockerfile of Mininet](http://github.com/opennetworkinglab/routing/tree/master/trellis/docker/Dockerfile)
