defmodule Otp.EmptyServer do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

end
