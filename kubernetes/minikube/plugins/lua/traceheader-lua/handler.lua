local uuid = require "resty.uuid"
local TraceHeader = {}

TraceHeader.PRIORITY = 1000
TraceHeader.VERSION = "1.0.0"

function TraceHeader:header_filter(conf)
    local trace_id = uuid.generate()

    kong.response.set_header(conf.trace_header, trace_id)
end

return TraceHeader
