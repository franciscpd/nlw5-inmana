defmodule Inmana.Supplies.Scheduler do
  use GenServer

  alias Inmana.Supplies.ExpirationNotify

  @milliseconds_in_week 1000 * 60 * 60 * 24 * 7

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state \\ %{}) do
    schedule_notification()
    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    ExpirationNotify.send()

    schedule_notification()

    {:noreply, state}
  end

  defp schedule_notification do
    Process.send_after(self(), :generate, @milliseconds_in_week)
  end

  # # async
  # def handle_cast({:put, key, value}, state) do
  #   {:noreply, Map.put(state, key, value)}
  # end

  # # sync
  # def handle_call({:get, key}, _from, state) do
  #   {:reply, Map.get(state, key), state}
  # end
end
