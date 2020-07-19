module ImageSerializer
  def attachment(image_field_name = :image, sizes = [:large, :medium, :thumb])
    sizes.map do |size|
      [size, object.public_send(image_field_name).public_send(size)]
    end.to_h
  end
end