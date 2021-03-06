require "administrate/base_dashboard"

class BadgeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    rarity: Field::BelongsTo,
    image: Field::Carrierwave.with_options(
      image: :medium,
      remove: true,
      remote_url: false
    ),
    confirmation_method: MultiSelectField.with_options(
      collection: Badge::CONFIRMATION_METHODS
    ),
    university: Field::BelongsTo,
    users: Field::HasMany,
    participation: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    bonus_description: Field::String,
    participation_terms: Field::String,
    city: Field::BelongsTo,
    description: Field::String,
    scope: Field::Select.with_options(
      collection: Badge::SCOPES
    ),
    created_at: Field::DateTime,
    ends_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    name
    rarity
    scope
    ends_at
    users
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    description
    participation_terms
    bonus_description
    image
    rarity
    scope
    city
    university
    participation
    ends_at
    created_at
    updated_at
    confirmation_method
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    description
    participation_terms
    bonus_description
    image
    rarity
    ends_at
    confirmation_method
    scope
    university
    city
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how badges are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(badge)
    badge.name
  end

  def permitted_attributes
    super + [confirmation_method: []]
  end
end
