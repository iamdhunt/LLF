if defined?(JsRoutes)
  JsRoutes.setup do |config|
    config.include = [/item/]
    config.default_url_options = {:locale => I18n.locale}
  end
end