defmodule RetWeb.Plugs.PostgrestProxy do
  use Plug.Builder

  plug :call

  @spec call(Plug.Conn.t(), []) :: Plug.Conn.t()
  def call(conn, []) do
    opts = ReverseProxyPlug.init(upstream: "http://#{hostname()}:3000")
    ReverseProxyPlug.call(conn, opts)
    IO.inspect(hostname(),label: "hostname fun =>")
    IO.puts "Hello word from media url 9"
  end

  @spec hostname :: String.t()
  defp hostname,
    do:
      :ret
      |> Application.fetch_env!(__MODULE__)
      |> Keyword.fetch!(:hostname)
end

defmodule RetWeb.Plugs.ItaProxy do
  use Plug.Builder
  plug ReverseProxyPlug, upstream: "http://localhost:6000"
  IO.puts "Hello word from media url 10"
end
