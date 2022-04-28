# aws_eip.eip0:
resource "aws_eip" "eip0" {
  network_border_group = "us-east-1"
  tags                 = {}
  vpc                  = true

  timeouts {}
}

# aws_security_group.sg0:
resource "aws_security_group" "sg0" {
    description = "JoseCarvalho - Security Group"
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
            description      = ""
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "78.29.147.32/32",
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
        {
            cidr_blocks      = [
                "78.29.147.32/32",
            ]
            description      = ""
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        },
        {
            cidr_blocks      = [
                "78.29.147.32/32",
            ]
            description      = ""
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name        = "JoseCarvalho"
    tags        = {}

    timeouts {}
}

# aws_instance.instance:
resource "aws_instance" "instance" {
    ami                          = "ami-04505e74c0741db8d"
    availability_zone            = "us-east-1f"
    instance_type                = "t2.micro"
    key_name                     = "vockey"
    security_groups              = [
        aws_security_group.sg0.name,
    ]
    vpc_security_group_ids       = [
        aws_security_group.sg0.id,
    ]
    root_block_device {
        delete_on_termination = true
        volume_size           = 30
        volume_type           = "gp2"
    }
     
}

# aws_eip_association.eip0_assoc:
resource "aws_eip_association" "eip0_assoc" {
  allocation_id        = aws_eip.eip0.id
instance_id          = aws_instance.instance.id
}
