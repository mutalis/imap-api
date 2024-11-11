import express, { Express, Request, Response } from "express";
import { router, publicProcedure, createContext } from "./trpc";
import * as trpcExpress from "@trpc/server/adapters/express";

import { db } from "./db";
import { z } from "zod";
import cors from "cors";

const app: Express = express();
app.use(
  cors({
    origin: "*", // Allow all origins
    methods: ["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);
const port = 3000;

const appRouter = router({
  userList: publicProcedure.query(async () => {
    // Retrieve users from a datasource
    const users = await db.user.findMany();
    return users;
  }),
  userById: publicProcedure.input(z.string()).query(async (opts) => {
    const { input } = opts;
    // Retrieve the user with the given ID from a datasource
    const user = await db.user.findById(input);
    return user;
  }),
  userCreate: publicProcedure
    .input(z.object({ name: z.string().min(5) }))
    .mutation(async (opts) => {
      const { input } = opts;
      // Create a new user with the given input in a datasource
      const user = await db.user.create(input);
      return user;
    }),
});

app.get("/", (req: Request, res: Response) => {
  res.send("Hello World from Express + TypeScript + Node.js !");
});

app.use(
  "/trpc",
  trpcExpress.createExpressMiddleware({
    router: appRouter,
    createContext,
  })
);

app.listen(port, () => {
  console.log(`Cyrus IMAP API Server listening on port ${port}`);
});

// Export type router type signature,
// NOT the router itself.
export type AppRouter = typeof appRouter;
