locals {
  formmated_project_name = lower(var.project_name)

  port_list = split(",", var.allowed_ports)

  sg_rules = [for port in local.port_list : {
    name = "port-${port}"
    port= port
    description = "Allow traffic rules on ${port}"
  }]

  instance_size = lookup(var.instance_size, var.environment, "t2.small")

  all_locations = concat(var.user_locations, var.default_locations)
  unique_locations = toset(local.all_locations)

  positive_cost = [for cost in var.monthly_costs : abs(cost)]
  max_cost = max(local.positive_cost...)
  min_cost = min(local.positive_cost...)
  total_cost = sum(local.positive_cost)
  avg_cost = local.total_cost / length(local.positive_cost)


  current_time = timestamp()
  format1 = formatdate("yyyyMMdd", local.current_time)
  format2 = formatdate("YYYY-MM-dd", local.current_time)
  current_time_now = "The time is ${local.format1}" 


  config_file_exist = fileexists("./config.json")
  config_data = local.config_file_exist ? jsondecode(file("./config.json")) : {}

}

