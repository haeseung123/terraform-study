## VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "RDS-test-vpc"
    }
}

## subnet
# public subnet
resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "public-subnet-1"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"

    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "public-subnet-2"
    }
}

# private subnet
resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "private-subnet-1"
    }
}

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"

    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "private-subnet-2"
    }
}

## internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "igw"
    }
}

## public route table
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "main_route"
    }
}

resource "aws_route_table_association" "route_table_association_1" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "route_table_association_2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.route_table.id
}

## EIP
resource "aws_eip" "nat_1" {
    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "nat-eip-1"
    }
}

resource "aws_eip" "nat_2" {
    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "nat-eip-2"
    }
}

## Nat gateway
resource "aws_nat_gateway" "nat_gateway_1" {
    allocation_id = aws_eip.nat_1.id
    subnet_id = aws_subnet.public_1.id

    tags = {
        Name = "nat-gw-1"
    }
}

resource "aws_nat_gateway" "nat_gateway_2" {
    allocation_id = aws_eip.nat_2.id
    subnet_id = aws_subnet.public_2.id

    tags = {
        Name = "nat-gw-2"
    }
}


## private route table
resource "aws_route_table" "route_table_private_1" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway_1.id
    }

    tags = {
        Name = "private-1-route"
    }
}

resource "aws_route_table" "route_table_private_2" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway_2.id
    }

    tags = {
        Name = "private-2-route"
    }
}

resource "aws_route_table_association" "route_table_association_private_1" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.route_table_private_1.id
}

resource "aws_route_table_association" "route_table_association_private_2" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.route_table_private_2.id
}