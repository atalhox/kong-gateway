// LoginPage.js
import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./Global.css";

function LoginPage() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch(`http://localhost:3001/api/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ username, password }),
      });

      if (response.ok) {
        const data = await response.json();
        localStorage.setItem("token", data.token);
        navigate("/profile");
      } else {
        setError("Usuário ou senha incorretos.");
      }
    } catch (error) {
      console.error("Erro ao fazer login:", error);
      setError("Ocorreu um erro. Tente novamente.");
    }
  };

  return (
    <div className="container">
      <h2 className="header">Login</h2>
      <form onSubmit={handleLogin} className="form">
        <div className="form-group">
          <label className="label">Usuário:</label>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
            className="input"
          />
        </div>
        <div className="form-group">
          <label className="label">Senha:</label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            className="input"
          />
        </div>
        <button type="submit" className="button">
          Entrar
        </button>
      </form>
      {error && <p className="error">{error}</p>}
    </div>
  );
}

export default LoginPage;
