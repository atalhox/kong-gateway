const { v4: uuidv4 } = require("uuid");

const TraceHeader = {
  PRIORITY: 1000,
  VERSION: "1.0.0",
};

TraceHeader.header_filter = function (conf) {
  const trace_id = uuidv4();

  kong.response.setHeader(conf.trace_header, trace_id);
};

module.exports = TraceHeader;
