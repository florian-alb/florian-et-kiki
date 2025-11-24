import express, { Express, Request, Response, NextFunction } from "express";

import { setupProxies } from "./proxy";
import { ROUTES } from "./routes";

const app: Express = express();
const port = process.env.PORT || 5555;

app.get("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("/ of Private API");
});

setupProxies(app, ROUTES);

app.use(function (err: any, req: Request, res: Response, next: NextFunction) {
  console.error(err.stack);
  res.status(500).send("Something broke!");
});

app.listen(port, () => {
  console.log(`Private API is running at http://localhost:${port}`);
});
