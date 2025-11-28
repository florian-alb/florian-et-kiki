import express, { Application } from "express";
import cors from "cors";
import userRouter from "./routes/user.routes";
import { errorHandler } from "./middlewares/error.middleware";

const createApp = (): Application => {
  const app = express();

  app.use(cors());
  app.use(express.json());

  app.use("/", userRouter);

  app.use(errorHandler);

  return app;
};

export default createApp;
