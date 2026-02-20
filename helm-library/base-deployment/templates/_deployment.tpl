{{- define "base-deployment.deployment" -}}
{{- $root := .root -}}
{{- $v := .values -}}

apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ required "baseDeployment.name is required" $v.name }}
  namespace: {{ $root.Release.Namespace }}
  labels:
    {{- toYaml $v.labels | nindent 4 }}

spec:
  replicas: {{ $v.replicas | default 1 }}

  {{- if $v.revisionHistoryLimit }}
  revisionHistoryLimit: {{ $v.revisionHistoryLimit }}
  {{- end }}

  {{- if $v.strategy }}
  strategy:
    {{- toYaml $v.strategy | nindent 4 }}
  {{- end }}

  selector:
    matchLabels:
      {{- toYaml $v.selectorLabels | nindent 6 }}

  template:
    metadata:
      labels:
        {{- toYaml $v.selectorLabels | nindent 8 }}


      {{- if and $v.reloader $v.reloader.enabled }}
      annotations:
        reloader.stakater.com/auto: "true"
      {{- end }}

    spec:
      {{- if $v.serviceAccountName }}
      serviceAccountName: {{ $v.serviceAccountName }}
      {{- end }}

      {{- if $v.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml $v.imagePullSecrets | nindent 8 }}
      {{- end }}

      {{- if $v.nodeSelector }}
      nodeSelector:
        {{- toYaml $v.nodeSelector | nindent 8 }}
      {{- end }}

      {{- if $v.tolerations }}
      tolerations:
        {{- toYaml $v.tolerations | nindent 8 }}
      {{- end }}

      {{- if $v.affinity }}
      affinity:
        {{- toYaml $v.affinity | nindent 8 }}
      {{- end }}

      containers:
        - name: {{ required "container.name is required" $v.container.name }}

          image: "{{ required "container.repository is required" $v.container.repository }}:{{ required "container.tag is required" $v.container.tag }}"

          imagePullPolicy: {{ $v.container.pullPolicy | default "IfNotPresent" }}

          ports:
            - containerPort: {{ required "container.port is required" $v.container.port }}

          {{- if $v.container.resources }}
          resources:
            {{- toYaml $v.container.resources | nindent 12 }}
          {{- end }}

          {{- if $v.container.env }}
          env:
            {{- toYaml $v.container.env | nindent 12 }}
          {{- end }}

          {{- if $v.container.envFrom }}
          envFrom:
            {{- toYaml $v.container.envFrom | nindent 12 }}
          {{- end }}

          {{- if and $v.probes $v.probes.enabled }}

            {{- if $v.probes.liveness.enabled }}
          livenessProbe:
            httpGet:
              path: {{ $v.probes.liveness.path }}
              port: {{ $v.container.port }}
            initialDelaySeconds: {{ $v.probes.liveness.initialDelaySeconds }}
            periodSeconds: {{ $v.probes.liveness.periodSeconds }}
            {{- end }}

            {{- if $v.probes.readiness.enabled }}
          readinessProbe:
            httpGet:
              path: {{ $v.probes.readiness.path }}
              port: {{ $v.container.port }}
            initialDelaySeconds: {{ $v.probes.readiness.initialDelaySeconds }}
            periodSeconds: {{ $v.probes.readiness.periodSeconds }}
            {{- end }}

            {{- if $v.probes.startup.enabled }}
          startupProbe:
            httpGet:
              path: {{ $v.probes.startup.path }}
              port: {{ $v.container.port }}
            failureThreshold: {{ $v.probes.startup.failureThreshold }}
            periodSeconds: {{ $v.probes.startup.periodSeconds }}
            {{- end }}

          {{- end }}

{{- end }}
