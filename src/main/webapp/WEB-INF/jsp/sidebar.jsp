<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">

<style>
:root {
    --sidebar-bg: #080c14;
    --sidebar-width: 240px;
    --accent: #3b82f6;
    --accent-glow: rgba(59,130,246,0.18);
    --border: rgba(255,255,255,0.06);
    --text-muted: rgba(255,255,255,0.35);
    --text-dim: rgba(255,255,255,0.6);
    --text-bright: #ffffff;
    --nav-hover-bg: rgba(59,130,246,0.10);
    --nav-active-bg: rgba(59,130,246,0.18);
}

* { box-sizing: border-box; margin: 0; padding: 0; }

.sidebar {
    width: var(--sidebar-width);
    min-height: 100vh;
    background: var(--sidebar-bg);
    border-right: 1px solid var(--border);
    display: flex;
    flex-direction: column;
    position: relative;
    overflow: hidden;
    flex-shrink: 0;
}

/* Subtle grid texture */
.sidebar::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
        linear-gradient(rgba(59,130,246,0.03) 1px, transparent 1px),
        linear-gradient(90deg, rgba(59,130,246,0.03) 1px, transparent 1px);
    background-size: 32px 32px;
    pointer-events: none;
}

/* Glow orb */
.sidebar::after {
    content: '';
    position: absolute;
    top: -60px;
    left: -60px;
    width: 200px;
    height: 200px;
    background: radial-gradient(circle, rgba(59,130,246,0.12) 0%, transparent 70%);
    pointer-events: none;
}

/* ── Brand ── */
.sidebar-brand {
    padding: 28px 24px 20px;
    border-bottom: 1px solid var(--border);
    position: relative;
    z-index: 1;
}

.brand-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: var(--accent-glow);
    border: 1px solid rgba(59,130,246,0.3);
    border-radius: 6px;
    padding: 4px 10px;
    margin-bottom: 10px;
}

.brand-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: var(--accent);
    box-shadow: 0 0 6px var(--accent);
    animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
    0%, 100% { opacity: 1; box-shadow: 0 0 6px var(--accent); }
    50%       { opacity: 0.5; box-shadow: 0 0 12px var(--accent); }
}

.brand-label {
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.12em;
    color: var(--accent);
    text-transform: uppercase;
}

.brand-title {
    font-family: 'Syne', sans-serif;
    font-size: 20px;
    font-weight: 800;
    color: var(--text-bright);
    letter-spacing: -0.02em;
    line-height: 1.1;
}

.brand-title span {
    color: var(--accent);
}

/* ── Nav ── */
.sidebar-nav {
    flex: 1;
    padding: 20px 14px;
    display: flex;
    flex-direction: column;
    gap: 2px;
    position: relative;
    z-index: 1;
}

.nav-section-label {
    font-family: 'DM Mono', monospace;
    font-size: 9px;
    letter-spacing: 0.15em;
    color: var(--text-muted);
    text-transform: uppercase;
    padding: 0 10px;
    margin: 12px 0 6px;
}

.nav-section-label:first-child { margin-top: 0; }

.nav-link {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 12px;
    border-radius: 8px;
    text-decoration: none;
    color: var(--text-dim);
    font-family: 'Syne', sans-serif;
    font-size: 13.5px;
    font-weight: 600;
    letter-spacing: 0.01em;
    transition: all 0.18s ease;
    border: 1px solid transparent;
    position: relative;
    overflow: hidden;
}

.nav-link::before {
    content: '';
    position: absolute;
    left: 0; top: 0; bottom: 0;
    width: 2px;
    background: var(--accent);
    border-radius: 0 2px 2px 0;
    transform: scaleY(0);
    transition: transform 0.18s ease;
}

.nav-link:hover {
    background: var(--nav-hover-bg);
    color: var(--text-bright);
    border-color: var(--border);
}

.nav-link:hover::before { transform: scaleY(0.5); }

.nav-link.active {
    background: var(--nav-active-bg);
    color: var(--text-bright);
    border-color: rgba(59,130,246,0.2);
}

.nav-link.active::before { transform: scaleY(1); }

.nav-icon {
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(255,255,255,0.04);
    border-radius: 6px;
    font-size: 13px;
    flex-shrink: 0;
    transition: background 0.18s ease;
}

.nav-link:hover .nav-icon,
.nav-link.active .nav-icon {
    background: var(--accent-glow);
}

.nav-link-text { flex: 1; }

.nav-arrow {
    font-size: 10px;
    opacity: 0;
    transform: translateX(-4px);
    transition: all 0.18s ease;
    color: var(--accent);
}

.nav-link:hover .nav-arrow,
.nav-link.active .nav-arrow {
    opacity: 1;
    transform: translateX(0);
}

/* Logout special */
.nav-link.logout {
    color: rgba(248, 113, 113, 0.6);
    margin-top: 4px;
}

.nav-link.logout:hover {
    background: rgba(239, 68, 68, 0.08);
    color: #f87171;
    border-color: rgba(239, 68, 68, 0.15);
}

.nav-link.logout::before { background: #ef4444; }
.nav-link.logout .nav-arrow { color: #f87171; }

/* ── Footer ── */
.sidebar-footer {
    padding: 16px 20px;
    border-top: 1px solid var(--border);
    position: relative;
    z-index: 1;
}

.footer-user {
    display: flex;
    align-items: center;
    gap: 10px;
}

.footer-avatar {
    width: 30px;
    height: 30px;
    border-radius: 8px;
    background: linear-gradient(135deg, #3b82f6, #6366f1);
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Syne', sans-serif;
    font-size: 12px;
    font-weight: 800;
    color: white;
    flex-shrink: 0;
}

.footer-info { flex: 1; min-width: 0; }

.footer-name {
    font-family: 'Syne', sans-serif;
    font-size: 12px;
    font-weight: 700;
    color: var(--text-bright);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.footer-role {
    font-family: 'DM Mono', monospace;
    font-size: 9px;
    color: var(--text-muted);
    letter-spacing: 0.08em;
    text-transform: uppercase;
}

.footer-version {
    font-family: 'DM Mono', monospace;
    font-size: 9px;
    color: var(--text-muted);
    letter-spacing: 0.06em;
}
</style>

<div class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-badge">
            <div class="brand-dot"></div>
            <span class="brand-label">Live</span>
        </div>
        <div class="brand-title">Sales<span>Panel</span></div>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-section-label">Main</div>

        <a href="/pages/customers" class="nav-link" id="nav-customers">
            <div class="nav-icon">👤</div>
            <span class="nav-link-text">Customers</span>
            <span class="nav-arrow">›</span>
        </a>

        <a href="/pages/products" class="nav-link" id="nav-products">
            <div class="nav-icon">📦</div>
            <span class="nav-link-text">Products</span>
            <span class="nav-arrow">›</span>
        </a>

        <a href="/pages/orders" class="nav-link" id="nav-orders">
            <div class="nav-icon">🛒</div>
            <span class="nav-link-text">Orders</span>
            <span class="nav-arrow">›</span>
        </a>

        <div class="nav-section-label">Account</div>

        <a href="#" onclick="logout(event)" class="nav-link logout">
            <div class="nav-icon">↩</div>
            <span class="nav-link-text">Logout</span>
            <span class="nav-arrow">›</span>
        </a>
    </nav>

    <div class="sidebar-footer">
        <div class="footer-user">
            <div class="footer-avatar">SP</div>
            <div class="footer-info">
                <div class="footer-name">Admin</div>
                <div class="footer-role">Administrator</div>
            </div>
            <div class="footer-version">v1.0</div>
        </div>
    </div>
</div>

<script>
// ── Active nav highlight ──────────────────────────────────────────────────
(function() {
    var path = window.location.pathname;
    var map  = { customers: '#nav-customers', products: '#nav-products', orders: '#nav-orders' };
    Object.keys(map).forEach(function(key) {
        if (path.indexOf(key) !== -1) {
            var el = document.querySelector(map[key]);
            if (el) el.classList.add('active');
        }
    });
})();

// ══ GLOBAL AUTH HELPERS ══════════════════════════════════════════════════
function authFetch(url, options) {
    var token = sessionStorage.getItem('token');
    options = options || {};
    options.headers = options.headers || {};
    if (token) options.headers['Authorization'] = 'Bearer ' + token;
    return fetch(url, options).then(function(res) {
        if (res.status === 401) {
            sessionStorage.removeItem('token');
            window.location.href = '/pages/login';
            return Promise.reject('Unauthorized');
        }
        return res;
    });
}

(function() {
    var token = sessionStorage.getItem('token');
    if (token) {
        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader('Authorization', 'Bearer ' + token);
            }
        });
    }
})();

(function() {
    var token = sessionStorage.getItem('token');
    if (!token || token.trim() === '') {
        window.location.href = '/pages/login';
        return;
    }
    fetch('/api/validate', {
        method: 'GET',
        headers: { 'Authorization': 'Bearer ' + token }
    }).then(function(res) {
        if (!res.ok) {
            sessionStorage.removeItem('token');
            sessionStorage.removeItem('refreshToken');
            window.location.href = '/pages/login';
        }
    });
})();

function logout(e) {
    if (e) e.preventDefault();
    sessionStorage.removeItem('token');
    sessionStorage.removeItem('refreshToken');
    window.location.href = '/pages/login';
}
</script>
