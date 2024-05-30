import { getSocketId, io } from "../../index.js";
import { Conversation } from "../models/conversation.model.js";
import { Message } from "../models/message.model.js";
import { User } from "../models/user.model.js";

async function sendMessage(req, res) {
  try {
    const { receiverId, message, senderId } = req.body;
    let conversation = await Conversation.findOne({
      participants: { $all: [receiverId, senderId] },
    });

    if (!conversation) {
      conversation = await Conversation.create({
        participants: [receiverId, senderId],
      });
    }

    const newMessage = new Message({
      message,
      senderId,
      receiverId,
    });

    conversation.messages.push(newMessage);
    await Promise.all([newMessage.save(), conversation.save()]);
    const socketId = getSocketId(receiverId);
    if (socketId) {
      io.to(socketId).emit("message", newMessage);
    }
    return res.status(201).send({
      msg: newMessage,
      status: true,
    });
  } catch (error) {
    console.log("Error in sendMessage controller: ", error);
    return res.status(500).send({
      error: error,
      status: false,
    });
  }
}

async function getMessages(req, res) {
  try {
    const { receiverId } = req.body;
    const senderId = req.user._id; // We will get this ID because we will set the user in the request when the user is logged in
    // const senderId = req.body.senderId;
    if (!receiverId || !senderId) {
      return res.status(400).send({
        msg: "Some error occurred not able to get IDs",
        status: false,
      });
    }
    const conversation = await Conversation.findOne({
      participants: { $all: [receiverId, senderId] },
    }).populate("messages");

    if (!conversation) {
      return res.status(404).send({
        msg: "Conversation not found",
        status: false,
      });
    }
    
    const messages = conversation.messages;
    return res.send({
      msg: messages,
      status: true,
    });
  } catch (error) {
    console.log("Error in getting all messages: ", error);
    return res.status(500).send({
      error: error,
      status: false,
    });
  }
}

export { sendMessage, getMessages };
