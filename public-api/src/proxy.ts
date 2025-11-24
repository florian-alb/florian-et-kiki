import { createProxyMiddleware } from "http-proxy-middleware";
import type { Application } from "express";
import { Route } from "./types";

const setupProxies = (app: Application, routes: Route[]) => {
  routes.forEach((route) => {
    app.use(route.url, createProxyMiddleware(route.proxy));
  });
};

export { setupProxies };
