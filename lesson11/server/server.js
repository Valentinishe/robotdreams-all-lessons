const express = require('express');
const app = express();
const port = 80;

app.get('/', (req, res) => {
  res.send(`Server running on ${ port }`);
});

app.get('*', (req, res) => {
  res.status(404).send('Page not found');
});

app.listen(port, () => {
  console.log(`Сервер працює на порті ${port}`);
});
