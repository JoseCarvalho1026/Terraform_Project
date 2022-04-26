# aws_eip.eip0:
resource "aws_eip" "eip0" {
    network_border_group = "us-east-1"
    tags                 = {}
    vpc                  = true

    timeouts {}
}

# aws_vpc.vpc0:
resource "aws_vpc" "vpc0" {
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "172.31.0.0/16"
    enable_classiclink               = false
    enable_classiclink_dns_support   = false
    enable_dns_hostnames             = true
    enable_dns_support               = true
    instance_tenancy                 = "default"
    tags                             = {}
}

# aws_security_group.sg0:
resource "aws_security_group" "sg0" {
    description = "Grupo de seguranca para o exercicio um"
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]
    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Permitir todo o ICMP"
            from_port        = -1
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "icmp"
            security_groups  = []
            self             = false
            to_port          = -1
        },
        {
            cidr_blocks      = [
                "78.29.147.32/32",
            ]
            description      = "Permitir UDP"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "udp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
        {
            cidr_blocks      = [
                "78.29.147.32/32",
            ]
            description      = "Permitir o HTTPs vindo do meu IP"
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = []
            description      = "Permitir o HTTP vindo de IPv6"
            from_port        = 80
            ipv6_cidr_blocks = [
                "::/0",
            ]
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name        = "grsi-security-group"
    tags        = {}
    vpc_id      = "vpc-09ab79262e9b1a9ee"

    timeouts {}
}

# aws_instance.instance0:
resource "aws_instance" "GRSI" {
    ami                          = "ami-0f9fc25dd2506cf6d"
    availability_zone            = "us-east-1b"
    instance_type                = "t2.micro"
    key_name                     = "vockey"
    security_groups              = [
        aws_security_group.sg0.name,
    ]
    vpc_security_group_ids       = [
        aws_vpc.vpc0.id,
    ]
    ebs_block_device {
        delete_on_termination = true
        device_name           = "/dev/sdb"
        volume_size           = 8
        volume_type           = "gp3"
    }
    root_block_device {
        delete_on_termination = true
        volume_size           = 8
        volume_type           = "gp2"
    }
     
}

# aws_eip_association.eip0_assoc:
resource "aws_eip_association" "eip0_assoc" {
  allocation_id        = aws_eip.eip0.id
instance_id          = aws_eip.eip0.id
}
