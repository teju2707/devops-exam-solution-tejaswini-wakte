resource "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.vpc.id
  cidr_block        = "10.0.9.0/24"  # CIDR block
  availability_zone = "ap-south-1a"
}

resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "lambda_sg" {
  vpc_id = data.aws_vpc.vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lambda_function" "api_invoker" {
  filename         = "lambda_function_payload.zip"
  function_name    = "api_invoker"
  role             = data.aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  vpc_config {
    subnet_ids         = [aws_subnet.private.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  environment {
    variables = {
      SUBNET_ID = aws_subnet.private.id
    }
  }
}
