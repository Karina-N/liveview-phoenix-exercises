defmodule LiveViewStudioWeb.VehiclesLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Vehicles

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        searchInput: "",
        vehicles: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>🚙 Find a Vehicle 🚘</h1>
    <div id="vehicles">
      <form phx-submit="search">
        <input
          type="text"
          name="searchInput"
          value={@searchInput}
          placeholder="Make or model"
          autofocus
          autocomplete="off"
          readonly={@loading}
        />

        <button>
          <img src="/images/search.svg" />
        </button>
      </form>

      <div :if={@loading} class="loader">Loading...</div>

      <div class="vehicles">
        <ul>
          <li :for={vehicle <- @vehicles}>
            <span class="make-model">
              <%= vehicle.make_model %>
            </span>
            <span class="color">
              <%= vehicle.color %>
            </span>
            <span class={"status #{vehicle.status}"}>
              <%= vehicle.status %>
            </span>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("search", %{"searchInput" => searchInput}, socket) do
    send(self(), {:run_search, searchInput})

    socket =
      assign(socket,
        searchInput: searchInput,
        vehicles: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_search, searchInput}, socket) do
    socket =
      assign(socket,
        vehicles: Vehicles.search(searchInput),
        loading: false
      )

    {:noreply, socket}
  end
end
