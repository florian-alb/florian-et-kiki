import { Route } from "./types";

export const ROUTES: Route[] = [
  {
    url: "/login",
    auth: false,
    creditCheck: false,
    proxy: {
      target: "http://localhost:5051",
      changeOrigin: true,
    },
  },
  {
    url: "/public-rest-ressource",
    auth: false,
    creditCheck: false,
    proxy: {
      target: "http://localhost:5052",
      changeOrigin: true,
    },
  },
];
