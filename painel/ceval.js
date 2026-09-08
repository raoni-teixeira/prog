/* Avaliador de um subconjunto de C, para o estudo de condicionais.
   Suporta: int/float, atribuicao, aritmetica, operadores relacionais e
   logicos, if/else if/else, blocos, printf, scanf, comentarios.
   NAO suporta lacos (proposital: esta pagina e sobre condicionais).
   Produz: saida, rastro das condicoes avaliadas e erros com linha. */

(function (root) {
  'use strict';

  var TIPOS = ['int', 'float'];
  var PALAVRAS = ['int', 'float', 'if', 'else', 'return', 'void', 'main'];

  function CErro(msg, linha, dica) {
    this.msg = msg; this.linha = linha; this.dica = dica || null; this.ehCErro = true;
  }

  /* ---------------- Lexico ---------------- */

  function lex(src) {
    var toks = [], i = 0, linha = 1, n = src.length;
    var OPS2 = ['==', '!=', '<=', '>=', '&&', '||', '+=', '-=', '*=', '/=', '%=', '++', '--'];

    while (i < n) {
      var c = src[i];

      if (c === '\n') { linha++; i++; continue; }
      if (c === ' ' || c === '\t' || c === '\r') { i++; continue; }

      if (c === '#') { while (i < n && src[i] !== '\n') i++; continue; }

      if (c === '/' && src[i + 1] === '/') { while (i < n && src[i] !== '\n') i++; continue; }
      if (c === '/' && src[i + 1] === '*') {
        var abriu = linha; i += 2;
        while (i < n && !(src[i] === '*' && src[i + 1] === '/')) { if (src[i] === '\n') linha++; i++; }
        if (i >= n) throw new CErro('O comentario /* ... */ foi aberto e nunca fechado.', abriu);
        i += 2; continue;
      }

      if (c === '"') {
        var s = '', ini = linha; i++;
        while (i < n && src[i] !== '"') {
          if (src[i] === '\\') {
            var e = src[i + 1];
            if (e === 'n') s += '\n';
            else if (e === 't') s += '\t';
            else if (e === '\\') s += '\\';
            else if (e === '"') s += '"';
            else if (e === '%') s += '%';
            else s += e;
            i += 2;
          } else {
            if (src[i] === '\n') throw new CErro('O texto entre aspas nao foi fechado nesta linha.', ini);
            s += src[i]; i++;
          }
        }
        if (i >= n) throw new CErro('Faltou fechar as aspas do texto.', ini);
        i++;
        toks.push({ t: 'str', v: s, linha: ini });
        continue;
      }

      if (c >= '0' && c <= '9') {
        var num = '';
        while (i < n && src[i] >= '0' && src[i] <= '9') { num += src[i]; i++; }
        var real = false;
        if (src[i] === '.' && src[i + 1] >= '0' && src[i + 1] <= '9') {
          real = true; num += '.'; i++;
          while (i < n && src[i] >= '0' && src[i] <= '9') { num += src[i]; i++; }
        }
        toks.push({ t: 'num', v: parseFloat(num), real: real, linha: linha });
        continue;
      }

      if (/[A-Za-z_]/.test(c)) {
        var id = '';
        while (i < n && /[A-Za-z0-9_]/.test(src[i])) { id += src[i]; i++; }
        toks.push({ t: PALAVRAS.indexOf(id) >= 0 ? id : 'id', v: id, linha: linha });
        continue;
      }

      var par2 = src.substr(i, 2);
      if (OPS2.indexOf(par2) >= 0) { toks.push({ t: par2, v: par2, linha: linha }); i += 2; continue; }

      if ('+-*/%<>=!&|(){};,&'.indexOf(c) >= 0) {
        toks.push({ t: c, v: c, linha: linha }); i++; continue;
      }

      throw new CErro('Nao entendi o caractere "' + c + '".', linha);
    }

    toks.push({ t: 'eof', v: '', linha: linha });
    return toks;
  }

  /* ---------------- Sintaxe ---------------- */

  function Parser(toks) {
    this.toks = toks; this.p = 0; this.avisos = [];
  }

  Parser.prototype.olha = function (k) { return this.toks[this.p + (k || 0)]; };
  Parser.prototype.tipo = function (k) { return this.olha(k).t; };
  Parser.prototype.linha = function () { return this.olha().linha; };

  Parser.prototype.come = function (t, oque) {
    if (this.tipo() !== t) {
      var achou = this.tipo() === 'eof' ? 'o fim do programa' : '"' + this.olha().v + '"';
      throw new CErro('Esperava ' + (oque || '"' + t + '"') + ' e encontrei ' + achou + '.', this.linha());
    }
    return this.toks[this.p++];
  };

  Parser.prototype.aceita = function (t) {
    if (this.tipo() === t) { this.p++; return true; }
    return false;
  };

  Parser.prototype.programa = function () {
    /* pula o cabecalho "int main(...) {" se existir */
    if (this.tipo() === 'int' && this.tipo(1) === 'main') {
      this.p += 2;
      this.come('(', 'um "(" depois de main');
      while (this.tipo() !== ')' && this.tipo() !== 'eof') this.p++;
      this.come(')', 'um ")" fechando main');
      this.come('{', 'a chave "{" que abre o corpo de main');
      var corpo = [];
      while (this.tipo() !== '}' && this.tipo() !== 'eof') corpo.push(this.comando());
      if (this.tipo() === 'eof') throw new CErro('Faltou a chave "}" que fecha main.', this.linha());
      this.p++;
      return corpo;
    }
    var lista = [];
    while (this.tipo() !== 'eof') lista.push(this.comando());
    return lista;
  };

  Parser.prototype.bloco = function () {
    var l = this.linha(); this.come('{');
    var cmds = [];
    while (this.tipo() !== '}' && this.tipo() !== 'eof') cmds.push(this.comando());
    if (this.tipo() === 'eof') throw new CErro('Faltou fechar a chave "{" aberta aqui.', l);
    this.p++;
    return { k: 'bloco', cmds: cmds, linha: l };
  };

  Parser.prototype.comando = function () {
    var l = this.linha(), t = this.tipo();

    if (t === ';') { this.p++; return { k: 'nada', linha: l }; }
    if (t === '{') return this.bloco();

    if (TIPOS.indexOf(t) >= 0) {
      this.p++;
      var decls = [];
      do {
        var nome = this.come('id', 'o nome de uma variavel').v;
        var ini = null;
        if (this.aceita('=')) ini = this.expr();
        decls.push({ nome: nome, ini: ini });
      } while (this.aceita(','));
      this.pontoEVirgula(l);
      return { k: 'decl', tipo: t, decls: decls, linha: l };
    }

    if (t === 'if') {
      this.p++;
      this.come('(', 'um "(" depois de if');
      var cond = this.expr();
      this.come(')', 'um ")" fechando a condicao do if');
      if (this.tipo() === ';') {
        this.avisos.push({
          linha: l,
          msg: 'Ha um ";" logo depois do if( ), antes do comando.',
          dica: 'Em C isso e legal: o corpo do if fica vazio e o comando seguinte roda sempre. Quase nunca e o que se quer.'
        });
      }
      var ent = this.comando(), sen = null;
      if (this.tipo() === 'else') { this.p++; sen = this.comando(); }
      return { k: 'if', cond: cond, ent: ent, sen: sen, linha: l };
    }

    if (t === 'else') {
      throw new CErro('Encontrei um "else" que nao pertence a nenhum if.', l,
        'Ou o if correspondente esta faltando, ou o comando antes do else foi fechado com ";" no lugar errado.');
    }

    if (t === 'return') {
      this.p++;
      if (this.tipo() !== ';') this.expr();
      this.pontoEVirgula(l);
      return { k: 'nada', linha: l };
    }

    if (t === 'id' && this.olha().v === 'printf') return this.printf();
    if (t === 'id' && this.olha().v === 'scanf') return this.scanf();

    var e = this.expr();
    this.pontoEVirgula(l);
    return { k: 'expr', e: e, linha: l };
  };

  Parser.prototype.pontoEVirgula = function (l) {
    if (this.tipo() !== ';') {
      throw new CErro('Faltou o ";" no fim do comando.', l);
    }
    this.p++;
  };

  Parser.prototype.printf = function () {
    var l = this.linha(); this.p++;
    this.come('(', 'um "(" depois de printf');
    var fmt = this.come('str', 'um texto entre aspas dentro do printf').v;
    var args = [];
    while (this.aceita(',')) args.push(this.expr());
    this.come(')', 'um ")" fechando o printf');
    this.pontoEVirgula(l);
    var n = (fmt.match(/%[dif]/g) || []).length;
    if (n !== args.length) {
      throw new CErro('O printf tem ' + n + ' marcador(es) %d/%f e ' + args.length + ' valor(es) depois do texto.', l,
        'Cada %d (ou %f) precisa de exatamente um valor correspondente, na mesma ordem.');
    }
    return { k: 'printf', fmt: fmt, args: args, linha: l };
  };

  Parser.prototype.scanf = function () {
    var l = this.linha(); this.p++;
    this.come('(', 'um "(" depois de scanf');
    this.come('str', 'um texto entre aspas dentro do scanf');
    var alvos = [];
    while (this.aceita(',')) {
      if (!this.aceita('&')) {
        this.avisos.push({
          linha: l,
          msg: 'Falta o "&" antes da variavel no scanf.',
          dica: 'O scanf precisa saber onde guardar o valor, e para isso recebe o endereco da variavel: &a.'
        });
      }
      alvos.push(this.come('id', 'o nome de uma variavel no scanf').v);
    }
    this.come(')', 'um ")" fechando o scanf');
    this.pontoEVirgula(l);
    return { k: 'scanf', alvos: alvos, linha: l };
  };

  /* precedencia: = < || < && < ==,!= < <,>,<=,>= < +,- < *,/,% < unario */

  Parser.prototype.expr = function () {
    if (this.tipo() === 'id' && this.tipo(1) === '=') {
      var l = this.linha(), nome = this.toks[this.p].v;
      this.p += 2;
      return { k: 'atrib', nome: nome, val: this.expr(), linha: l };
    }
    if (this.tipo() === 'id' && ['+=', '-=', '*=', '/=', '%='].indexOf(this.tipo(1)) >= 0) {
      var l2 = this.linha(), nm = this.toks[this.p].v, op = this.tipo(1);
      this.p += 2;
      return { k: 'atrib', nome: nm, linha: l2,
        val: { k: 'bin', op: op[0], a: { k: 'var', nome: nm, linha: l2 }, b: this.expr(), linha: l2 } };
    }
    return this.ou();
  };

  function nivel(nome, ops, prox) {
    Parser.prototype[nome] = function () {
      var e = this[prox]();
      while (ops.indexOf(this.tipo()) >= 0) {
        var op = this.tipo(), l = this.linha();
        this.p++;
        e = { k: 'bin', op: op, a: e, b: this[prox](), linha: l };
      }
      return e;
    };
  }

  nivel('ou', ['||'], 'e');
  nivel('e', ['&&'], 'igual');
  nivel('igual', ['==', '!='], 'rel');
  nivel('rel', ['<', '>', '<=', '>='], 'soma');
  nivel('soma', ['+', '-'], 'mult');
  nivel('mult', ['*', '/', '%'], 'unario');

  Parser.prototype.unario = function () {
    var l = this.linha();
    if (this.tipo() === '!') { this.p++; return { k: 'nao', e: this.unario(), linha: l }; }
    if (this.tipo() === '-') { this.p++; return { k: 'neg', e: this.unario(), linha: l }; }
    if (this.tipo() === '+') { this.p++; return this.unario(); }
    return this.primario();
  };

  Parser.prototype.primario = function () {
    var tk = this.olha(), l = tk.linha;
    if (tk.t === 'num') { this.p++; return { k: 'num', v: tk.v, real: tk.real, linha: l }; }
    if (tk.t === 'id') { this.p++; return { k: 'var', nome: tk.v, linha: l }; }
    if (tk.t === '(') {
      this.p++;
      var e = this.expr();
      this.come(')', 'um ")" fechando o parenteses');
      return e;
    }
    if (tk.t === 'str') throw new CErro('Encontrei um texto entre aspas onde esperava um numero ou variavel.', l);
    throw new CErro('Esperava um valor e encontrei "' + (tk.v || 'fim do programa') + '".', l);
  };

  /* ---------------- Execucao ---------------- */

  function Maquina(entradas) {
    this.vars = {};
    this.tipos = {};
    this.saida = '';
    this.rastro = [];
    this.entradas = (entradas || []).slice();
    this.passos = 0;
  }

  Maquina.prototype.leVar = function (nome, linha) {
    if (!(nome in this.vars)) {
      throw new CErro('A variavel "' + nome + '" esta sendo usada sem ter sido declarada.', linha,
        'Declare antes de usar, por exemplo: int ' + nome + ';');
    }
    return this.vars[nome];
  };

  Maquina.prototype.gravaVar = function (nome, v, linha) {
    if (!(nome in this.vars)) {
      throw new CErro('A variavel "' + nome + '" esta recebendo um valor sem ter sido declarada.', linha,
        'Declare antes de usar, por exemplo: int ' + nome + ';');
    }
    if (this.tipos[nome] === 'int') v = Math.trunc(v);
    this.vars[nome] = v;
    return v;
  };

  Maquina.prototype.aval = function (no) {
    var m = this;
    switch (no.k) {
      case 'num': return no.v;
      case 'var': return m.leVar(no.nome, no.linha);
      case 'neg': return -m.aval(no.e);
      case 'nao': return m.aval(no.e) === 0 ? 1 : 0;
      case 'atrib': return m.gravaVar(no.nome, m.aval(no.val), no.linha);
      case 'bin': {
        if (no.op === '&&') return (m.aval(no.a) !== 0 && m.aval(no.b) !== 0) ? 1 : 0;
        if (no.op === '||') return (m.aval(no.a) !== 0 || m.aval(no.b) !== 0) ? 1 : 0;
        var a = m.aval(no.a), b = m.aval(no.b);
        switch (no.op) {
          case '+': return a + b;
          case '-': return a - b;
          case '*': return a * b;
          case '/':
            if (b === 0) throw new CErro('Divisao por zero.', no.linha);
            return (Number.isInteger(a) && Number.isInteger(b)) ? Math.trunc(a / b) : a / b;
          case '%':
            if (b === 0) throw new CErro('Resto de divisao por zero.', no.linha);
            return a % b;
          case '<': return a < b ? 1 : 0;
          case '>': return a > b ? 1 : 0;
          case '<=': return a <= b ? 1 : 0;
          case '>=': return a >= b ? 1 : 0;
          case '==': return a === b ? 1 : 0;
          case '!=': return a !== b ? 1 : 0;
        }
      }
    }
    throw new CErro('Nao consegui avaliar esta expressao.', no.linha);
  };

  function formata(fmt, vals) {
    var i = 0;
    return fmt.replace(/%(\.(\d+))?([dif])/g, function (_, __, casas, tipo) {
      var v = vals[i++];
      if (tipo === 'd' || tipo === 'i') return String(Math.trunc(v));
      return casas === undefined ? Number(v).toFixed(6) : Number(v).toFixed(Number(casas));
    });
  }

  Maquina.prototype.roda = function (cmds) {
    for (var i = 0; i < cmds.length; i++) this.exec(cmds[i]);
  };

  Maquina.prototype.exec = function (c) {
    if (++this.passos > 20000) throw new CErro('O programa executou comandos demais e foi interrompido.', c.linha);
    var m = this;
    switch (c.k) {
      case 'nada': return;
      case 'bloco': return m.roda(c.cmds);
      case 'decl':
        c.decls.forEach(function (d) {
          if (d.nome in m.vars) {
            throw new CErro('A variavel "' + d.nome + '" ja foi declarada antes.', c.linha);
          }
          m.tipos[d.nome] = c.tipo;
          m.vars[d.nome] = 0;
          if (d.ini) m.gravaVar(d.nome, m.aval(d.ini), c.linha);
        });
        return;
      case 'expr': m.aval(c.e); return;
      case 'printf': m.saida += formata(c.fmt, c.args.map(function (a) { return m.aval(a); })); return;
      case 'scanf':
        c.alvos.forEach(function (nome) {
          if (m.entradas.length === 0) {
            throw new CErro('O scanf pediu um valor, mas nao ha mais entradas disponiveis.', c.linha,
              'Informe todos os valores de entrada antes de executar.');
          }
          if (!(nome in m.vars)) {
            throw new CErro('A variavel "' + nome + '" do scanf nao foi declarada.', c.linha);
          }
          m.gravaVar(nome, m.entradas.shift(), c.linha);
        });
        return;
      case 'if': {
        var v = m.aval(c.cond);
        m.rastro.push({ linha: c.linha, valor: v, verdadeiro: v !== 0 });
        if (v !== 0) m.exec(c.ent);
        else if (c.sen) m.exec(c.sen);
        return;
      }
    }
    throw new CErro('Comando desconhecido.', c.linha);
  };

  /* ---------------- API ---------------- */

  function analisa(src) {
    var p = new Parser(lex(src));
    var arv = p.programa();
    return { arv: arv, avisos: p.avisos };
  }

  function executa(src, entradas) {
    try {
      var r = analisa(src);
      var m = new Maquina(entradas);
      m.roda(r.arv);
      return { ok: true, saida: m.saida, rastro: m.rastro, avisos: r.avisos };
    } catch (e) {
      if (e && e.ehCErro) {
        return { ok: false, erro: { msg: e.msg, linha: e.linha, dica: e.dica }, saida: '', rastro: [], avisos: [] };
      }
      throw e;
    }
  }

  var api = { executa: executa, analisa: analisa, lex: lex, CErro: CErro };
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  else root.CEval = api;
})(typeof globalThis !== 'undefined' ? globalThis : this);
