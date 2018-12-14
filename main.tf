//--------------------------------------------------------------------
// Variables
variable "aws_pes_database_pwd" {}

//--------------------------------------------------------------------
// Workspace Data
data "terraform_remote_state" "p_tfe_network" {
  backend = "atlas"
  config {
    name    = "pTFE/Network"
  }
}

//--------------------------------------------------------------------
// Modules
module "aws_pes" {
  source  = "app.terraform.io/pTFE/aws-pes/ptfe"
  version = "1.4.0"

  aws_instance_type = "m4.large"
  database_pwd = "${var.aws_pes_database_pwd}"
  db_subnet_group_name = "darnold-ptfe"
  namespace = "darnold-ptfe"
  owner = "darnold@hashicorp.com"
  private_route53_zone = "false"
  route53_zone = "hashidemos.io"
  ssh_key_name = "tfe-demos-darnold"
  subnet_ids = ["${data.terraform_remote_state.p_tfe_network.public_subnet}"]
  ttl = "-1"
  vpc_security_group_ids = "${data.terraform_remote_state.p_tfe_network.admin_sg}"
}
