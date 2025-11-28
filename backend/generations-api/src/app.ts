import express, { Application } from "express";
import cors from "cors";
import generationRouter from "./routes/generation.routes";
import { errorHandler } from "./middlewares/error.middleware";

const createApp = (): Application => {
  const app = express();

  app.use(cors());
  app.use(express.json());

  app.use("/", generationRouter);

  app.use(errorHandler);

  return app;
};

export default createApp;
