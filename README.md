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

