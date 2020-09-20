# frozen_string_literal: true

class ShowButtonComponent < ViewComponent::Base
  def initialize(record:, content: 'show')
    @record = record
    @content = content
  end

  def call
    link_to(@content, @record, class: 'uk-button uk-button-default')
  end
end
