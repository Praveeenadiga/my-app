output "cluster_name" {
  description = "The EKS cluster name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "The EKS cluster endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate" {
  description = "The EKS cluster CA certificate"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}
