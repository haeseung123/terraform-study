resource "aws_launch_template" "as_conf" {
    name_prefix = "as_conf"
    image_id = "ami-09a7535106fbd42d5"
    instance_type = "t2.micro"
    #vpc_security_group_ids = [aws_security_group.bastion.id]

    network_interfaces {
        associate_public_ip_address = true
        subnet_id = aws_subnet.public_1.id
        security_groups = [aws_security_group.bastion.id]
    }

    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = "bastion-host"
        }
    }
}

resource "aws_autoscaling_group" "bastion_asg" {
    name = "bastion-host-asg"
    
    launch_template {
        id = aws_launch_template.as_conf.id
        version = "$Latest"
    }

    vpc_zone_identifier = [aws_subnet.public_1.id, aws_subnet.public_2.id]
    min_size = 1
    max_size = 3
    desired_capacity = 2
    health_check_grace_period = 300
    health_check_type = "EC2"
}