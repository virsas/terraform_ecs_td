provider "aws" {
  region = var.region
}

resource "aws_ecs_task_definition" "task" {
  family                = var.task.name
  container_definitions = <<-EOI
[
  {
    "name": "${var.task.name}",
    "image": "${var.ecr}:latest",
    "cpu": ${var.task.cpu},
    "memory": ${var.task.memory},
    "environment": [
          ${var.variables}
        ],
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${var.task.serviceContainerPort},
        "hostPort": ${var.task.serviceHostPort}
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "/ecs/${var.task.name}",
            "awslogs-region": "${var.region}"
          }
      }
  }
]
EOI
  network_mode = "bridge"
}