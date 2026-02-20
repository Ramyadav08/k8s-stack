{{- define "base-secret.externalsecret" -}}
{{- $root := .root -}}
{{- $v := .values -}}

apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ $v.name }}
  namespace: {{ $root.Release.Namespace }}
spec:
  refreshInterval: 1m
  secretStoreRef:
    name: {{ $v.secretStoreName }}
    kind: ClusterSecretStore
  target:
    name: {{ $v.targetName }}
    creationPolicy: Owner
    deletionPolicy: Retain
  dataFrom:
    - extract:
        key: name:{{ $v.remoteSecretName }}
{{- end }}
