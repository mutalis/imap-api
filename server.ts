import express, { Express, Request, Response } from "express";

const app: Express = express();
const port = 3000;

app.get("/", (req: Request, res: Response) => {
  res.send("Hello World from Express + TypeScript + Node.js !");
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
