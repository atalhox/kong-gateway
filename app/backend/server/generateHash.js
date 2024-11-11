const bcrypt = require("bcrypt");

async function generateHash() {
  const password = "secret";
  const hash = await bcrypt.hash(password, 10);
  console.log("Hash gerada:", hash);
}

generateHash();
