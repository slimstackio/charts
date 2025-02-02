{{- define "customerID" -}}
{{- .Values.customerID | required ".Values.customerID is required." -}}
{{- end }}

{{- define "clusterID" -}}
{{- .Values.clusterID | required ".Values.clusterID is required." -}}
{{- end }}

{{- define "auth.filePath" -}}
{{- range .Values.prometheus.server.extraSecretMounts }}
  {{- if eq .name "auth-file" }}
    {{- .mountPath }}/token
  {{- end }}
{{- end }}
{{- end }}

{{- define "auth.secretName" -}}
{{- range .Values.prometheus.server.extraSecretMounts }}
  {{- if eq .name "auth-file" }}
    {{- .secretName }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "auth.username" -}}
{{ .Values.customerID }}
{{- end }}

{{- define "saas.endpoint" -}}
{{ $url := printf "https://%s-ingest.app.slimstack.io" .Values.customerID -}}
{{ default $url .Values.urlOverride}}
{{- end }}

{{- define "mutator.image" -}}
{{ .Values.mutator.image.repository }}:{{ .Values.mutator.image.tag }}
{{- end }}

{{- define "collector.image" -}}
{{ .Values.collector.image.repository }}:{{ .Values.collector.image.tag }}
{{- end }}

{{- define "mutator.fullname" -}}
{{- printf "%s-%s" (include "slimstack.fullname" .) .Values.mutator.name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "recommender.fullname" -}}
{{- printf "%s-%s" (include "slimstack.fullname" .) .Values.recommender.name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "collector.fullname" -}}
{{- printf "%s-%s" (include "slimstack.fullname" .) .Values.collector.name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "api.url" -}}
{{- if .Values.collector.apiUrlOverride -}}
  {{ .Values.collector.apiUrlOverride }}
{{- else -}}
  {{ include "saas.endpoint" .}}
{{- end }}
{{- end }}