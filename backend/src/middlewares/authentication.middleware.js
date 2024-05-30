import jwt from "jsonwebtoken";

const checkUserAuthentication = (req, res, next) => {
  try {
    /// Authorization will be Bearer token so splitting the token from Bearer
    const token = req.headers.authorization.split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).send({
      status: false,
      message: "User not authenticated",
    });
  }
};

export { checkUserAuthentication };
