module.exports = {
  name: "trace-header-js",
  fields: [
    {
      config: {
        type: "record",
        fields: [
          {
            trace_header: {
              type: "string",
              default: "X-Trace-ID",
              required: true,
            },
          },
        ],
      },
    },
  ],
};
