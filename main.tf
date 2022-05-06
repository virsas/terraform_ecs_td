provider "aws" {
  region = var.region
}

resource "aws_ecs_task_definition" "service" {
  family                = var.task.name
  container_definitions = <<-EOI
[
  {
    "name": "${var.task.name}",
    "image": "${var.ecr}:latest",
    "cpu": ${var.task.cpu},
    "memory": ${var.task.memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${var.task.serviceContainerPort},
        "hostPort": ${var.task.serviceHostPort}
      },
      {
        "containerPort": ${var.task.metricsContainerPort},
        "hostPort": ${var.task.metricsHostPort}
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "/ecs/${var.task.name}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": ""
          }
      }
  }
]
EOI
  network_mode = "bridge"
}