<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

<style>
:root {
    --sidebar-bg: #ffffff;
    --sidebar-width: 240px;
    --accent: #2563eb;
    --accent-glow: rgba(37,99,235,0.15);
    --border: rgba(99,115,155,0.12);
    --text-muted: #94a3b8;
    --text-dim: #64748b;
    --text-bright: #0f172a;
    --nav-hover-bg: #f8faff;
    --nav-active-bg: #eff4ff;
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
    font-family: 'Plus Jakarta Sans', sans-serif;
}

/* Subtle grid texture adapted for light mode */
.sidebar::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
        linear-gradient(rgba(99,115,155,0.04) 1px, transparent 1px),
        linear-gradient(90deg, rgba(99,115,155,0.04) 1px, transparent 1px);
    background-size: 32px 32px;
    pointer-events: none;
}

/* Glow orb adapted for light mode */
.sidebar::after {
    content: '';
    position: absolute;
    top: -60px;
    left: -60px;
    width: 200px;
    height: 200px;
    background: radial-gradient(circle, rgba(37,99,235,0.08) 0%, transparent 70%);
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
    background: var(--nav-active-bg);
    border: 1px solid rgba(37,99,235,0.2);
    border-radius: 6px;
    padding: 4px 10px;
    margin-bottom: 10px;
}

.brand-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: var(--accent);
    box-shadow: 0 0 6px var(--accent-glow);
    animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
    0%, 100% { opacity: 1; box-shadow: 0 0 6px rgba(37,99,235,0.4); }
    50%       { opacity: 0.5; box-shadow: 0 0 12px rgba(37,99,235,0.2); }
}

.brand-label {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.12em;
    color: var(--accent);
    text-transform: uppercase;
    font-weight: 700;
}

.brand-title {
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 22px;
    font-weight: 800;
    color: var(--text-bright);
    letter-spacing: -0.04em;
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
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.1em;
    color: var(--text-muted);
    font-weight: 600;
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
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13.5px;
    font-weight: 600;
    transition: all 0.18s ease;
    border: 1px solid transparent;
    position: relative;
    overflow: hidden;
}

.nav-link::before {
    content: '';
    position: absolute;
    left: 0; top: 0; bottom: 0;
    width: 3px;
    background: var(--accent);
    border-radius: 0 3px 3px 0;
    transform: scaleY(0);
    transition: transform 0.18s ease;
}

.nav-link:hover {
    background: var(--nav-hover-bg);
    color: var(--text-bright);
    border-color: rgba(99,115,155,0.08);
}

.nav-link:hover::before { transform: scaleY(0.5); }

.nav-link.active {
    background: var(--nav-active-bg);
    color: var(--accent);
    border-color: rgba(37,99,235,0.15);
}

.nav-link.active::before { transform: scaleY(1); }

.nav-icon {
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f0f4fa;
    color: var(--text-dim);
    border-radius: 6px;
    font-size: 13px;
    flex-shrink: 0;
    transition: all 0.18s ease;
}

.nav-link:hover .nav-icon {
    background: white;
    box-shadow: 0 2px 6px rgba(15,23,42,0.04);
}

.nav-link.active .nav-icon {
    background: white;
    color: var(--accent);
    box-shadow: 0 2px 8px var(--accent-glow);
}

.nav-link-text { flex: 1; }

.nav-arrow {
    font-size: 11px;
    opacity: 0;
    transform: translateX(-4px);
    transition: all 0.18s ease;
    color: var(--accent);
    font-weight: 800;
}

.nav-link:hover .nav-arrow,
.nav-link.active .nav-arrow {
    opacity: 1;
    transform: translateX(0);
}

/* Logout special */
.nav-link.logout {
    color: #ef4444;
    margin-top: 4px;
}

.nav-link.logout .nav-icon {
    background: #fff1f1;
    color: #ef4444;
}

.nav-link.logout:hover {
    background: #fff1f1;
    color: #dc2626;
    border-color: rgba(220, 38, 38, 0.15);
}

.nav-link.logout:hover .nav-icon {
    background: white;
    box-shadow: 0 2px 6px rgba(220,38,38,0.1);
}

.nav-link.logout::before { background: #dc2626; }
.nav-link.logout .nav-arrow { color: #dc2626; }

/* ── Footer ── */
.sidebar-footer {
    padding: 16px 20px;
    border-top: 1px solid var(--border);
    position: relative;
    z-index: 1;
    background: #f8faff;
}

.footer-user {
    display: flex;
    align-items: center;
    gap: 10px;
}

.footer-avatar {
    width: 34px;
    height: 34px;
    border-radius: 10px;
    background: linear-gradient(135deg, #3b82f6, #6366f1);
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 700;
    color: white;
    flex-shrink: 0;
}

.footer-info { flex: 1; min-width: 0; }

.footer-name {
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 700;
    color: var(--text-bright);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.footer-role {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    color: var(--text-muted);
    letter-spacing: 0.04em;
    text-transform: uppercase;
    margin-top: 2px;
}

.footer-version {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    color: var(--text-muted);
    font-weight: 500;
}
</style>

<div class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-title">Sales<span>Panel</span></div>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-section-label">Main</div>

        <a href="/pages/customers" class="nav-link" id="nav-customers">
            <div class="nav-icon">👤</div>
            <span class="nav-link-text">Customers</span>
            <span class="nav-arrow">›</span>
        </a>

        <a href="/pages/dashboard" class="nav-link" id="nav-dashboard">
                    <div class="nav-icon">📊</div>
                    <span class="nav-link-text">Dashboard</span>
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