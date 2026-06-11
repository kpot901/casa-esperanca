# 🏡 Casa de Acolhimento Esperança — Site Institucional
**Projeto Integrador Web Standards | N2WEBS20261F | 2025**
Prof. Lucio Luzetti Criado | Centro Universitário ENIAC

---

## 👥 Integrantes
| Nome | RA | Responsabilidade |
|---|---|---|
| Arthur Jacob de Barros Lima | 203302025 | Coordenação técnica, HTML/CSS/JS, estrutura do projeto |
| Gabriel Duarte dos Santos | — | Interfaces visuais, acessibilidade, testes |
| Giovanna Boanares de Alencar | — | Requisitos, conteúdo, formulário JS |

---

## 📁 Estrutura do Projeto

```
casa-esperanca/
├── index.html            ← Home (hero, missão, projetos, stats)
├── quem-somos.html       ← História, MVV, timeline, equipe
├── projetos.html         ← Grid com filtros por status + modais
├── como-ajudar.html      ← Doação financeira (Pix), itens, voluntariado
├── contato.html          ← Formulário com validação JS completa + LGPD
├── css/
│   ├── style.css         ← Design system global (tokens, navbar, footer)
│   └── home.css          ← Estilos específicos da Home
├── js/
│   └── global.js         ← Navbar scroll/hamburger, active link, scroll reveal
└── sql/
    └── banco_casa_esperanca.sql  ← Schema completo + seed + views
```

---

## ✅ Funcionalidades implementadas

### Site (HTML + CSS + JavaScript)
- [x] Navbar fixa responsiva com hambúrguer mobile
- [x] Hero animado com stats e CTAs
- [x] Scroll reveal com IntersectionObserver (performance)
- [x] Filtro de projetos por status (tabs) com aria-selected
- [x] Modal de detalhes dos projetos com fechar por Esc
- [x] Botão "Copiar chave Pix" com toast de feedback
- [x] Validação JS em tempo real: regex e-mail, minlength, obrigatórios
- [x] Máscara de telefone
- [x] Checkbox LGPD obrigatório (Lei 13.709/2018)
- [x] Estado de sucesso após envio do formulário
- [x] Layout responsivo 320px → 1440px
- [x] Foco visível e atributos ARIA (acessibilidade WCAG 2.1)
- [x] Redução de movimento respeitada via prefers-reduced-motion

### Banco de Dados (MySQL/MariaDB)
- [x] 6 tabelas: CONTATOS, VOLUNTARIOS, PROJETOS, DOACOES, VOLUNTARIOS_PROJETOS, NECESSIDADES
- [x] Chaves primárias, estrangeiras e constraints
- [x] Índices para queries de administração
- [x] 3 Views: projetos_resumo, necessidades_urgentes, contatos_nao_lidos
- [x] Dados seed realistas para demonstração
- [x] Comentários explicativos em cada campo

---

## 🎥 Roteiro do Vídeo (Sprint 3 — 3 a 5 min)

### [0:00–0:30] Abertura + Apresentação dos integrantes
> "Olá! Somos o grupo do Projeto Integrador Web Standards da disciplina N2WEBS20261F.
> Vou apresentar os integrantes: Arthur Jacob de Barros Lima (RA 203302025), Gabriel Duarte dos Santos e Giovanna Boanares de Alencar."
> *(mostrar foto/rosto de cada um)*

### [0:30–1:00] O Problema
> "A Casa de Acolhimento Esperança é uma ONG em São Paulo que atende crianças em vulnerabilidade social há mais de 12 anos.
> O problema identificado: a instituição não possuía presença digital. Toda comunicação com doadores e voluntários era feita por grupos de WhatsApp, gerando perda de oportunidades e falta de transparência."

### [1:00–1:30] Cliente e Público-alvo + Impacto Social
> "Nosso cliente é a própria Casa Esperança. Os públicos do site são: doadores, voluntários, parceiros institucionais e a comunidade geral.
> O impacto social é direto: a ONG atende mais de 120 crianças por ano. Com o site, ampliamos o alcance da captação de recursos e voluntários, potencialmente beneficiando centenas de crianças."

### [1:30–2:00] Requisitos / Páginas
> "O site possui 5 páginas: Home, Quem Somos, Projetos, Como Ajudar e Contato.
> Tecnologias utilizadas: HTML, CSS e JavaScript puros — sem frameworks.
> O banco de dados foi modelado em MySQL com 6 tabelas."

### [2:00–3:30] Demo do site funcionando
> *(abrir index.html no navegador)*
> - Home: hero, missão, cards, stats, projetos em destaque
> - Quem Somos: timeline, MVV, equipe
> - Projetos: demonstrar os filtros de tab, abrir um modal
> - Como Ajudar: mostrar dados Pix, clicar em "Copiar Pix", ver toast
> - Contato: tentar enviar vazio (mostrar erros), preencher corretamente (mostrar sucesso)

### [3:30–4:00] Banco de dados
> *(abrir banco_casa_esperanca.sql ou MySQL Workbench)*
> "O banco de dados possui 6 entidades relacionadas. Destacamos a tabela CONTATOS como origem de dados do formulário, e a tabela VOLUNTARIOS como extensão 1:1 para voluntários. A tabela VOLUNTARIOS_PROJETOS resolve a relação N:M entre voluntários e projetos."

### [4:00–4:30] Conclusão
> "Com esse projeto, a Casa de Acolhimento Esperança ganha presença digital estruturada, canal confiável para captação de doadores e voluntários, e transparência sobre suas ações.
> O código está versionado no GitHub e o site está pronto para publicação no GitHub Pages.
> Obrigado!"

---

## 🚀 Como executar localmente

Abra `index.html` diretamente no navegador (Chrome, Edge ou Firefox).
Não é necessário servidor local para as páginas HTML/CSS/JS.

Para o banco de dados:
```sql
mysql -u root -p < sql/banco_casa_esperanca.sql
```

---

## 🔗 Links (preencher antes da entrega)
- **Vídeo YouTube:** https://youtu.be/
- **Repositório Git:** https://github.com/

---

## 📋 ODS Atendidos
| ODS | Descrição | Relação |
|---|---|---|
| ODS 3 | Saúde e Bem-Estar | Fortalece instituição que protege crianças |
| ODS 4 | Educação de Qualidade | Divulga projetos educativos da ONG |
| ODS 9 | Inovação e Infraestrutura | Tecnologia web como impacto social |
| ODS 17 | Parcerias e Implementação | Amplifica rede de doadores e voluntários |
