{{- define "base-service.service" -}}
{{- $root := .root -}}
{{- $v := .values -}}

apiVersion: v1
kind: Service
metadata:
  name: {{ required "baseService.name is required" $v.name }}
  namespace: {{ $root.Release.Namespace }}
  labels:
    {{- toYaml $v.labels | nindent 4 }}

spec:
  type: {{ $v.type | default "ClusterIP" }}

  selector:
    {{- toYaml $v.selectorLabels | nindent 4 }}

  ports:
    {{- toYaml $v.ports | nindent 4 }}

{{- end }}
