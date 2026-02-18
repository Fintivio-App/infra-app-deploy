{{- define "generic-backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "generic-backend.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "generic-backend.name" . -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "generic-backend.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "generic-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "generic-backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generic-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "generic-backend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "generic-backend.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "generic-backend.image" -}}
{{- if or (eq .Values.image.repository "") (eq .Values.image.tag "") -}}
{{- fail "image.repository and image.tag must be set" -}}
{{- end -}}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag -}}
{{- end -}}

{{- define "generic-backend.secretName" -}}
{{- if .Values.secretEnv.name -}}
{{- .Values.secretEnv.name -}}
{{- else -}}
{{- include "generic-backend.fullname" . -}}
{{- end -}}
{{- end -}}
