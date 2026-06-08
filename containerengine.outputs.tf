output "clusters" {
  value = { for k, v in module.clusters :
    k => {
      id                        = v.id
      endpoints                 = v.endpoints
      kubernetes_network_config = v.kubernetes_network_config
      service_lb_subnet_ids     = v.service_lb_subnet_ids
      worker_nodes = zipmap(keys(module.node_pools), [
        for pool in values(module.node_pools) :
        [for node in pool.nodes : node.private_ip]
      ])
    }
  }
}
