//--------------------------------------------------------------------
// Variables

variable "aws_pes_database_pwd" {}

//--------------------------------------------------------------------
// Modules
module "aws_network" {
  source  = "app.terraform.io/pTFE/aws-network/ptfe"
  version = "1.0.0"

  namespace = "darnold-ptfe"
}

module "aws_pes" {
  source  = "app.terraform.io/pTFE/aws-pes/ptfe"
  version = "1.4.0"

  aws_instance_type = "m4.large"
  database_pwd = "${var.aws_pes_database_pwd}"
  db_subnet_group_name = "${module.aws_network.db_subnet_group_id}"
  namespace = "darnold-ptfe"
  owner = "darnold"
  private_route53_zone = "false"
  route53_zone = "hashidemos.io"
  ssh_key_name = "tfe-demos-darnold"
  subnet_ids = "${module.aws_network.subnet_ids}"
  ttl = "-1"
  vpc_security_group_ids = "${module.aws_network.security_group_id}"
}
