module ImageSerializer
  def attachment(image_field_name = :image, sizes = %i[large medium thumb])
    sizes.index_with do |size|
      object.public_send(image_field_name).public_send(size)
    end
  end
end
