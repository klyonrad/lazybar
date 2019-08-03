# frozen_string_literal: true

RailsAdmin.config do |config|
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)
  config.show_gravatar = false

  # hopefully temporary workaround https://github.com/sferik/rails_admin/issues/3157
  config.excluded_models << 'ActionMailbox::InboundEmail'
  config.excluded_models << 'ActionText::RichText'

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
