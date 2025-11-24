import { Route } from "./types";

export const ROUTES: Route[] = [
  {
    url: "/public",
    auth: false,
    creditCheck: false,
    proxy: {
      target: "http://localhost:5050",
      changeOrigin: true,
    },
  },
  {
    url: "/private",
    auth: false,
    creditCheck: false,
    proxy: {
      target: "http://localhost:5555",
      changeOrigin: true,
    },
  },
];
