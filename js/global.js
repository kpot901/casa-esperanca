/* ============================================================
   CASA DE ACOLHIMENTO ESPERANÇA — Global JS
   ============================================================ */

// ── Navbar scroll shadow + hamburger ──
(function () {
  const nav  = document.querySelector('.navbar');
  const ham  = document.querySelector('.navbar__hamburger');
  const menu = document.querySelector('.navbar__menu');

  if (nav) {
    window.addEventListener('scroll', () => {
      nav.classList.toggle('scrolled', window.scrollY > 20);
    });
  }

  if (ham && menu) {
    ham.addEventListener('click', () => {
      const open = menu.classList.toggle('open');
      ham.setAttribute('aria-expanded', open);
    });
    // Close on link click
    menu.querySelectorAll('a').forEach(a => {
      a.addEventListener('click', () => {
        menu.classList.remove('open');
        ham.setAttribute('aria-expanded', 'false');
      });
    });
    // Close on outside click
    document.addEventListener('click', e => {
      if (!nav.contains(e.target)) {
        menu.classList.remove('open');
        ham.setAttribute('aria-expanded', 'false');
      }
    });
  }
})();

// ── Active nav link ──
(function () {
  const path = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.navbar__link').forEach(a => {
    if (a.getAttribute('href') === path) a.classList.add('active');
  });
})();

// ── Scroll reveal (IntersectionObserver) ──
(function () {
  const els = document.querySelectorAll('[data-reveal]');
  if (!els.length) return;

  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) { e.target.classList.add('revealed'); io.unobserve(e.target); }
    });
  }, { threshold: 0.12 });

  els.forEach(el => io.observe(el));
})();

// CSS for reveal
const style = document.createElement('style');
style.textContent = `
[data-reveal] { opacity:0; transform:translateY(24px); transition: opacity .55s ease, transform .55s ease; }
[data-reveal].revealed { opacity:1; transform:none; }
[data-reveal][data-delay="1"] { transition-delay:.1s; }
[data-reveal][data-delay="2"] { transition-delay:.2s; }
[data-reveal][data-delay="3"] { transition-delay:.3s; }
`;
document.head.appendChild(style);
