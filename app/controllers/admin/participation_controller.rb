module Admin
  class ParticipationController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    def update
      requested_resource.assign_attributes(resource_params)

      if requested_resource.confirmed_changed?
        if participation_status_confirmed?
          requested_resource.user.score += requested_resource.badge.scores_count
        else
          requested_resource.user.score -= requested_resource.badge.scores_count
        end

        requested_resource.user.save
      end

      super
    end

    def destroy
      if requested_resource.destroy
        requested_resource.user.score -= requested_resource.badge.scores_count if requested_resource.confirmed?
        requested_resource.user.save

        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:error] = requested_resource.errors.full_messages.join("<br/>")
      end
      redirect_to action: :index
    end

    def participation_status_confirmed?
      requested_resource.changes["confirmed"] == [false, true]
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end