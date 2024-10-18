return {
    name = "trace-header-lua",
    fields = {
        {
            config = {
                type = "record",
                fields = {
                    { trace_header = { type = "string", default = "X-Trace-ID", required = true }, },
                },
            },
        },
    }
}
