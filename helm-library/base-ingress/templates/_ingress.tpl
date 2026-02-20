{{- define "base-ingress.ingress" -}}
{{- $root := .root -}}
{{- $v := .values -}}

{{- if $v.enabled }}

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $v.name }}
  namespace: {{ $root.Release.Namespace }}

  {{- if $v.annotations }}
  annotations:
    {{- toYaml $v.annotations | nindent 4 }}
  {{- end }}

spec:
  ingressClassName: {{ $v.className | default "nginx" }}

  rules:
    {{- toYaml $v.rules | nindent 4 }}

  {{- if $v.tls }}
  tls:
    {{- toYaml $v.tls | nindent 4 }}
  {{- end }}

{{- end }}
{{- end }}
