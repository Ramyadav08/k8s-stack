{{- define "base-hpa.hpa" -}}
{{- $root := .root -}}
{{- $v := .values -}}

{{- if $v.enabled }}

apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ $v.name }}
  namespace: {{ $root.Release.Namespace }}

spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ $v.targetDeployment }}

  minReplicas: {{ $v.minReplicas }}
  maxReplicas: {{ $v.maxReplicas }}

  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ $v.cpuUtilization }}

{{- end }}
{{- end }}
