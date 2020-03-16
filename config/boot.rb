# frozen_string_literal: true

require 'bundler/setup'
require 'nakayoshi_fork'
require 'hanami/api'
require 'clamby'

Clamby.configure(
  {
    check: false,
    daemonize: true,
    config_file: nil,
    error_clamscan_missing: true,
    error_clamscan_client_error: false,
    error_file_missing: true,
    error_file_virus: false,
    fdpass: true,
    stream: false,
    output_level: 'medium', # one of 'off', 'low', 'medium', 'high'
    executable_path_clamscan: 'clamscan',
    executable_path_clamdscan: 'clamdscan',
    executable_path_freshclam: 'freshclam'
  }
)
