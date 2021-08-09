provider "aws"{
    region = "us-east-2"
    access_key = "AKIA6KZQ3UPJQBV6AKGC"
    secret_key = "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"
}
resource "aws_instance" "adi_instance"{
    ami = "ami-0233c2d874b811deb"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.adi_sg.name]
    depends_on = [aws_eip.adi_eip]
}

resource "aws_eip" "adi_eip"{
    instance = aws_instance.adi_instance.id
    depends_on = [aws_security_group.adi_sg]
}
resource "aws_security_group" "adi_sg"{
    name = "Allow https"
    ingress{
        from_port = 443
        to_port = 443 
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 443
        to_port = 443 
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
output "EIP"{
value = aws_eip.adi_eip.public_ip
}
