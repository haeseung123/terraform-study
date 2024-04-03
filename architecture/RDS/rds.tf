resource "aws_db_subnet_group" "db-subnet-group" {
    name = "db-cluster-subnet-group"
    subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

resource "aws_rds_cluster" "aurora-mysql-db" {
    cluster_identifier = "mysql-test-1"
    db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
    vpc_security_group_ids = [aws_security_group.db.id]
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.1"
    availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
    database_name = "testdb"
    master_username = "test"
    master_password = "test123#"
    skip_final_snapshot = true
}

output "rds_writer_endpoint" {
    value = aws_rds_cluster.aurora-mysql-db.endpoint
}

resource "aws_rds_cluster_instance" "aurora-mysql-db-instance" {
    count = 2
    identifier = "mysql-test-1-${count.index}"
    cluster_identifier = aws_rds_cluster.aurora-mysql-db.id
    instance_class = "db.t3.small"
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.1"
}