# Useful APIs:

```
> iex -S mix
```

## Sequence
```
> {:ok,pid} = GenServer.start_link(Otp.Sequence, 100, [debug: [:trace, :statistics]])
> GenServer.call(pid, :next_number)
> GenServer.cast(pid, {:increment_number, 5})
> :sys.statistics pid, :get
> :sys.get_status pid
> :sys.trace pid, false
> :sys.statistics pid, false
```

## Stack
```
# > {:ok,pid} = GenServer.start_link(Otp.Stack, [5,"cat",9], [debug: [:trace, :statistics]])
# > GenServer.call(pid, :pop)
# > GenServer.cast(pid, {:push, "Dog"})
```
