
module "aws_eks_cluster" {
    source = "../"

    // put this in terraform.tfvars

    access_key = var.access_key
    secret_key = var.secret_key

    eks_cluster_name    = var.eks_cluster_name
    region              = var.instance_region
    vpc_id              = var.aws_default_vpc # use aws_default_vpc?
    ip_ranges           = var.ip_ranges # used ["0.0.0.0/0"]
    subnet_ids          = var.subnet_ids # use aws_default_subnets?
    instance_type       = var.instance_type # "aws_ami" "name" ami = instance_type = "t2.nano"
    desired_size        = var.desired_size
    max_size            = var.max_size # 1 cluster size?
    min_size            = var.min_size 
}