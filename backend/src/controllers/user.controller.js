import { User } from "../models/user.model.js";
import { generateJwtToken } from "../utils/generate_jwt.js";
import { uploadOnCloudinary } from "../utils/upload_on_cloudinary.js";

async function registerUser(req, res) {
  try {
    const { fullName, email, password } = JSON.parse(req.body.json);
    const profilePic = req.file;

    if (!fullName || !email || !password) {
      return res.status(400).send({
        msg: "Please fill all the fields",
        status: false,
      });
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.send({ status: false, message: "User already exists" });
    }
    if (!profilePic) {
      return res.status(400).send({
        msg: "Please upload profile pic",
        status: false,
      });
    }
    /// Upload profile pic on cloudinary
    const result = await uploadOnCloudinary(profilePic.path);
    if (result == null) {
      return res.send({
        status: false,
        message: "Not able to upload profile pic on server",
      });
    }
    
    const user = await User.create({
      fullName,
      email,
      password,
      profilePic: result.url,
    });

    return res.status(201).send({
      status: true,
      user: user,
    });

  } catch (error) {

    console.log("Error in registerUser", error.message);
    res.send({
      status: false,
      message: error.message,
    });
  }
}


async function loginUser(req, res) {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email: email });
    if (!user) return res.send({ status: false, message: "User not found" });

    const isMatch = await user.comparePassword(password);
    if (isMatch === false)
      return res.send({ status: false, message: "Invalid password" });

    let tokenData = {
      id: user._id,
      profilePic: user.profilePic,
      email: user.email,
      fullName: user.fullName,
    };

    let token = generateJwtToken(
      tokenData,
      process.env.JWT_SECRET_KEY,  
      "30d"
    );

    res.status(200).send({
      status: true,
      token: token,
    });

  } catch (error) {
    res.send({
      status: false,
      message: error.message,
    });
  }
}

export { registerUser, loginUser };
