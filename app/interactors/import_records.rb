class ImportRecords
  include Interactor

  delegate :model, :data, :find_by_columns, :successful_imports, :failed_imports, to: :context

  def call
    context.successful_imports = 0
    context.failed_imports = 0

    data.each do |element|
      instance = model.find_by(element.to_h.slice(*find_by_columns))

      unless instance
        new_instance = model.new(element.to_h)
        new_instance.save ? context.successful_imports += 1 : context.failed_imports += 1
      end
    end
  end
end
