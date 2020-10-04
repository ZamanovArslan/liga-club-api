ActiveModel::Serializer.config.default_includes = "**"

ActiveModelSerializers.config.key_transform = :underscore
ActiveModelSerializers.config.adapter = :json
