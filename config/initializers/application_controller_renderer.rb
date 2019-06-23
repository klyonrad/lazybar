# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

# Try current unreleased version of this
class DummyCompiler < ERB::Compiler # :nodoc:
  def compile_content(stag, out)
    out.push "_erbout << ''" if stag == '<%='
  end
end
