require "administrate/field/base"

class MultiSelectField < Administrate::Field::Base
  def to_s
    data.join(", ")
  end

  def selectable_options
    collection
  end

  private

  def collection
    options.fetch(:collection, [])
  end
end
