defmodule LiveViewStudioWeb.CustomComponents do
  use Phoenix.Component

  # these declarations below apply only to the component that follow immediately
  slot(:legal)
  slot(:inner_block, required: true)

  # here we display value that already is in the 'assigns' map (PART 1)
  attr(:expiration, :integer, default: 24)

  # here we display value that is NOT in the 'assigns' map (PART 1)
  # attr(:minutes, :integer)

  def promo(assigns) do
    # here we display value that already is in the 'assigns' map (PART 2)
    assigns = assign(assigns, :minutes, assigns.expiration * 60)

    # here we display value that is NOT in the 'assigns' map (PART 2)
    # assigns = assign_new(assigns, :minutes, fn -> assigns.expiration * 60 end)

    ~H"""
    <div class="promo">
      <div class="deal">
        <%= render_slot(@inner_block) %>
      </div>
      <div class="expiration">
        <%!-- Deal expires in <%= @expiration %> hours --%>
        Deal expires in <%= @minutes %> minutes
      </div>
      <div class="legal">
        <%= render_slot(@legal) %>
      </div>
    </div>
    """
  end
end
