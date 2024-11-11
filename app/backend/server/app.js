const express = require("express");
const cors = require("cors");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const app = express();

// Configuração do CORS
app.use(
  cors({
    origin: "http://localhost:3000",
  })
);

app.use(express.json());

const users = [
  {
    id: 1,
    username: "admin",
    password: "$2b$10$u0gHigL0qOn68om1kvwA0.PV502P9wJ2XiNHBR3Hujady2KdqoAMa",
  },
];

const JWT_SECRET = "sua-chave-secreta-muito-segura";

app.post("/api/login", async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res
      .status(400)
      .json({ message: "Username e password são obrigatórios" });
  }

  const user = users.find((u) => u.username === username);
  if (!user) {
    return res.status(401).json({ message: "Credenciais inválidas" });
  }

  const passwordMatch = await bcrypt.compare(password, user.password);
  if (!passwordMatch) {
    return res.status(401).json({ message: "Credenciais inválidas" });
  }

  const token = jwt.sign(
    { userId: user.id, username: user.username },
    JWT_SECRET,
    { expiresIn: "1h" }
  );

  res.status(200).json({ message: "Login realizado com sucesso", token });
});

const authMiddleware = (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) {
    return res.status(401).json({ message: "Token não fornecido" });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ message: "Token inválido" });
  }
};

app.get("/api/profile", authMiddleware, (req, res) => {
  res.json({
    message: "Rota protegida",
    user: req.user,
  });
});

app.listen(3001, () => {
  console.log("Servidor rodando na porta 3001");
});
