{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "common.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "common.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{- define "load.internal.grpcProxyPort" -}}
    {{- $v := $.Files.Get "internal.values.yaml" | fromYaml }}
    {{- print $v.internal.grpcProxyPort }}
{{- end -}}

{{- define  "backup.endpoint" -}}
    {{- if .Values.backup.endpoint -}}
        {{- print .Values.backup.endpoint -}}
     {{- else}}
        {{- printf "http://%s.%s.svc.cluster.local:%s" .Values.backup.serviceName .Release.Namespace (.Values.backup.port | toString) -}}
     {{- end}}
{{- end -}}