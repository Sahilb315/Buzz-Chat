import express from "express";
import { sendMessage, getMessages } from "../controllers/message.controller.js";

const messageRouter = express.Router();


messageRouter.post("/send", sendMessage)
messageRouter.get("/get", getMessages)

export { messageRouter}