const express = require('express');
const bodyParser = require('body-parser');
const db = require('./connection');

const app = express();
const port = 1802;

app.use(bodyParser.json());

app.get('/aluno', async (req, res) => {
    try {
      const result = await db.query(`SELECT * FROM dbo.sel_aluno(${req.query.codigo})`);
      res.status(200).json(result.rows);
    } catch (err) {
      console.error(err);
    }
  })
  app.get('/curso', async (req, res) => {
    try {
        const result = await db.query(`SELECT * FROM dbo.sel_curso(${req.query.codigo})`);
      
      res.status(200).json(result.rows);
    } catch (err) {
      console.error(err);
    }
  })
  app.get('/matricula', async (req, res) => {
    try {
        const result = await db.query(`select * from dbo.sel_matricula()`);
      
      res.status(200).json(result.rows);
    } catch (err) {
      console.error(err);
    }
  })

app.post('/addaluno', (req,res) => {
  try {
    const result = db.query(`call dbo.add_aluno(${req.query.nome})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.post('/addcurso', (req,res) => {
  try {
    console.log(`call dbo.add_curso(${req.query.descricao},${req.query.ementa})`);
    const result = db.query(`call dbo.add_curso(${req.query.descricao},${req.query.ementa})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.post('/addmatricula', (req,res) => {
  try {
    console.log(`call dbo.add_matricula(${req.query.codcurso},${req.query.codaluno})`);
    const result = db.query(`call dbo.add_matricula(${req.query.codcurso},${req.query.codaluno})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.put('/updaluno',(req,res) => {
  try {
    const result = db.query(`call dbo.upd_aluno(${req.query.codigo},${req.query.nome})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.put('/updcurso',(req,res) => {
  try {
    const result = db.query(`call dbo.upd_curso(${req.query.codigo},${req.query.descricao},${req.query.ementa})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.delete('/delaluno',(req,res) => {
  try {
    const result = db.query(`call dbo.del_aluno(${req.query.codigo})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.delete('/delcurso',(req,res) => {
  try {
    const result = db.query(`call dbo.del_curso(${req.query.codigo})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.delete('/delmatricula',(req,res) => {
  try {
    const result = db.query(`call dbo.del_matricula(${req.query.codigo})`);
    res.status(200).json('{sucess=true}')
  } catch (err) {
    console.error(err);
  }
})

app.listen(port,() => {
    console.log("running...");
})
