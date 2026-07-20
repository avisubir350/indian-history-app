/* ============================================================
   Bharata Katha — Main JavaScript
   ============================================================ */

// ── Mobile Menu ──────────────────────────────────────────────
function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    if (menu) menu.classList.toggle('open');
}

// ── Toggle Password Visibility ────────────────────────────────
function togglePassword(fieldId) {
    const field = document.getElementById(fieldId);
    const icon  = document.getElementById('eyeIcon');
    if (!field) return;
    if (field.type === 'password') {
        field.type = 'text';
        if (icon) { icon.classList.remove('fa-eye'); icon.classList.add('fa-eye-slash'); }
    } else {
        field.type = 'password';
        if (icon) { icon.classList.remove('fa-eye-slash'); icon.classList.add('fa-eye'); }
    }
}

// ── Password Strength Meter ───────────────────────────────────
const pwInput = document.getElementById('password');
if (pwInput && document.getElementById('pwStrength')) {
    pwInput.addEventListener('input', function () {
        const val  = this.value;
        const bar  = document.getElementById('strengthBar');
        const text = document.getElementById('strengthText');
        let score  = 0;
        if (val.length >= 6)           score++;
        if (val.length >= 10)          score++;
        if (/[A-Z]/.test(val))         score++;
        if (/[0-9]/.test(val))         score++;
        if (/[^a-zA-Z0-9]/.test(val))  score++;

        const levels = [
            { pct: '0%',   bg: '#ccc',     label: 'Enter a password' },
            { pct: '20%',  bg: '#E74C3C',  label: 'Very Weak' },
            { pct: '40%',  bg: '#E67E22',  label: 'Weak' },
            { pct: '60%',  bg: '#F39C12',  label: 'Fair' },
            { pct: '80%',  bg: '#27AE60',  label: 'Strong' },
            { pct: '100%', bg: '#16A085',  label: 'Very Strong' },
        ];
        const l = levels[score];
        if (bar)  { bar.style.width = l.pct; bar.style.background = l.bg; }
        if (text) { text.textContent = l.label; text.style.color = l.bg; }
    });
}

// ── Share Story ───────────────────────────────────────────────
function shareStory() {
    const url = window.location.href;
    if (navigator.clipboard) {
        navigator.clipboard.writeText(url).then(() => {
            const fb = document.getElementById('shareFeedback');
            if (fb) { fb.textContent = '✓ Link copied!'; setTimeout(() => fb.textContent = '', 2500); }
        });
    } else {
        const el = document.createElement('textarea');
        el.value = url; document.body.appendChild(el); el.select(); document.execCommand('copy');
        document.body.removeChild(el);
    }
}

// ── Animate numbers in stats ──────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    const dateEl = document.getElementById('adminDate');
    if (dateEl) {
        dateEl.textContent = new Date().toLocaleDateString('en-IN', {
            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
        });
    }

    // Scroll-reveal animation
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.topic-card, .story-card').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity .5s ease, transform .5s ease';
        observer.observe(el);
    });
});

// IntersectionObserver callback adds 'visible' which triggers animation
const style = document.createElement('style');
style.textContent = '.topic-card.visible, .story-card.visible { opacity:1 !important; transform:none !important; }';
document.head.appendChild(style);
