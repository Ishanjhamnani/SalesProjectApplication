<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login — SalesProject</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
        --bg: #f0f4fa;
        --border: rgba(99,115,155,0.12);
        --accent: #2563eb;
        --accent-glow: rgba(37,99,235,0.15);
        --text: #0f172a;
        --muted: #64748b;
        --error: #dc2626;
        --error-bg: #fff1f1;
        --success: #16a34a;
    }
    html, body {
        height: 100%;
        font-family: 'Plus Jakarta Sans', sans-serif;
        background: var(--bg);
        color: var(--text);
        overflow: hidden;
    }

    /* Light theme animated background grid */
    .bg-grid {
        position: fixed; inset: 0;
        background-image:
            linear-gradient(rgba(99,115,155,0.05) 1px, transparent 1px),
            linear-gradient(90deg, rgba(99,115,155,0.05) 1px, transparent 1px);
        background-size: 48px 48px;
        z-index: 0;
        animation: gridFloat 20s linear infinite;
    }
    @keyframes gridFloat { 0%{transform:translateY(0);} 100%{transform:translateY(48px);} }

    /* Soft light theme orbs */
    .bg-orb {
        position: fixed; border-radius: 50%; filter: blur(90px); z-index: 0;
        animation: drift 15s ease-in-out infinite alternate;
    }
    .bg-orb-1 {
        width: 600px; height: 600px;
        background: radial-gradient(circle, rgba(37,99,235,0.08) 0%, rgba(79,70,229,0.04) 50%, transparent 80%);
        top: -150px; left: -120px;
    }
    .bg-orb-2 {
        width: 500px; height: 500px;
        background: radial-gradient(circle, rgba(139,92,246,0.06) 0%, rgba(37,99,235,0.03) 60%, transparent 85%);
        bottom: -120px; right: -100px; animation-delay: -7s;
    }
    @keyframes drift {
        0%{transform:translate(0,0) scale(1);}
        100%{transform:translate(40px,30px) scale(1.1);}
    }

    .page { position: relative; z-index: 1; display: flex; height: 100vh; }

    /* Left panel for light theme */
    .left-panel {
        flex: 1; display: flex; flex-direction: column; justify-content: center; padding: 60px;
        position: relative; overflow: hidden;
    }

    .brand {
        font-size: 20px; font-weight: 800; letter-spacing: -0.02em;
        color: var(--text); margin-bottom: 48px; display: flex; align-items: center; gap: 10px;
    }
    .brand-dot {
        width: 8px; height: 8px; background: var(--accent); border-radius: 50%;
        box-shadow: 0 0 10px var(--accent-glow); animation: pulse 2.5s ease-in-out infinite;
        position: relative;
    }
    .brand-dot::after {
        content: ''; position: absolute; inset: -3px; border-radius: 50%;
        border: 1px solid rgba(37,99,235,0.2); animation: ripple 2s ease-out infinite;
    }
    @keyframes ripple { 0%{transform:scale(1); opacity:1;} 100%{transform:scale(2); opacity:0;} }
    @keyframes pulse { 0%,100%{opacity:1;transform:scale(1);} 50%{opacity:0.8;transform:scale(0.9);} }

    .left-headline {
        font-size: clamp(42px, 5vw, 56px); font-weight: 800;
        line-height: 1.1; letter-spacing: -0.03em; margin-bottom: 20px; color: #0f172a;
    }
    .left-headline span {
        color: var(--accent);
    }

    .left-sub {
        font-size: 16px; color: var(--muted); line-height: 1.6; max-width: 420px;
        margin-bottom: 60px;
    }

    /* Light theme stats */
    .stats-row { display: flex; gap: 48px; }
    .stat { display: flex; flex-direction: column; gap: 4px; position: relative; }
    .stat:not(:last-child)::after {
        content: ''; position: absolute; right: -24px; top: 50%; transform: translateY(-50%);
        width: 1px; height: 30px; background: var(--border);
    }
    .stat-num {
        font-size: 28px; font-weight: 800; color: #0f172a;
        letter-spacing: -0.05em; line-height: 1;
    }
    .stat-label {
        font-size: 11px; font-weight: 600; color: #64748b;
        text-transform: uppercase; letter-spacing: 0.04em;
    }

    /* ── SOOTHING TINTED RIGHT PANEL ── */
    .right-panel {
        width: 520px; flex-shrink: 0; display: flex; align-items: center; justify-content: center;
        padding: 40px;
        /* Very soft, soothing pale blue-gray gradient instead of harsh white */
        background: linear-gradient(135deg, #eaf0f8 0%, #e1e8f3 100%);
        border-left: 1px solid var(--border);
        box-shadow: -10px 0 40px rgba(15,23,42,0.03);
        z-index: 10;
        position: relative;
        overflow: hidden;
    }

    /* Vibrant but soft glowing orbs specifically inside the right panel to add depth */
    .right-panel::before {
        content: ''; position: absolute; top: -100px; right: -100px;
        width: 450px; height: 450px; border-radius: 50%;
        background: radial-gradient(circle, rgba(37,99,235,0.15) 0%, transparent 70%);
        pointer-events: none;
    }
    .right-panel::after {
        content: ''; position: absolute; bottom: -80px; left: -80px;
        width: 400px; height: 400px; border-radius: 50%;
        background: radial-gradient(circle, rgba(139,92,246,0.12) 0%, transparent 70%);
        pointer-events: none;
    }

    /* ── FROSTED GLASS LOGIN CARD ── */
    .login-card {
        width: 100%; max-width: 380px;
        position: relative; z-index: 1;
        animation: slideUp 0.5s cubic-bezier(0.16,1,0.3,1) both;

        /* Glassmorphism Effect */
        background: rgba(255, 255, 255, 0.65);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.8);
        border-radius: 24px;
        padding: 48px 40px;
        box-shadow: 0 16px 40px rgba(15, 23, 42, 0.04),
                    inset 0 0 0 1px rgba(255,255,255,0.5);
    }
    @keyframes slideUp {
        from{opacity:0;transform:translateY(20px);}
        to{opacity:1;transform:translateY(0);}
    }

    .card-title {
        font-size: 26px; font-weight: 800; margin-bottom: 6px;
        letter-spacing: -0.03em; color: #0f172a;
    }
    .card-sub { font-size: 14px; color: var(--muted); margin-bottom: 32px; }

    /* Input Forms */
    .form-group { margin-bottom: 20px; }
    .form-label {
        display: block; font-size: 11.5px; font-weight: 700; color: #64748b;
        margin-bottom: 6px; letter-spacing: 0.02em; transition: color 0.2s;
    }
    .form-group:focus-within .form-label { color: var(--accent); }

    .input-wrap { position: relative; }
    .input-icon {
        position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
        color: #94a3b8; font-size: 16px; pointer-events: none; transition: all 0.2s;
    }
    .input-wrap:focus-within .input-icon { color: var(--accent); }

    .form-input {
        width: 100%; padding: 12px 14px 12px 42px;
        background: #ffffff; /* Solid white inputs pop beautifully on frosted glass */
        border: 1.5px solid #cbd5e1;
        border-radius: 12px; color: #0f172a; font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 14px; outline: none; transition: all 0.2s ease;
        box-shadow: inset 0 2px 4px rgba(15,23,42,0.02);
    }
    .form-input::placeholder { color: #94a3b8; }
    .form-input:hover { border-color: #94a3b8; }
    .form-input:focus {
        border-color: var(--accent); background: #ffffff;
        box-shadow: 0 0 0 3px var(--accent-glow);
    }

    .form-input.error {
        border-color: var(--error); background: #fff1f1;
        box-shadow: 0 0 0 3px rgba(220,38,38,0.1);
        animation: shake 0.3s ease;
    }
    @keyframes shake {
        0%,100%{transform:translateX(0);}
        25%{transform:translateX(-4px);}
        75%{transform:translateX(4px);}
    }

    .pw-toggle {
        position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
        background: none; border: none; cursor: pointer; color: #94a3b8;
        font-size: 16px; padding: 4px; border-radius: 6px; transition: all 0.2s;
    }
    .pw-toggle:hover { color: #0f172a; background: #f1f5f9; }

    .field-error {
        display: none; font-size: 11.5px; font-weight: 600; color: var(--error);
        margin-top: 6px; padding-left: 2px;
    }

    /* Alerts */
    .alert {
        display: none; padding: 12px 14px; border-radius: 10px; font-size: 13px; font-weight: 600;
        margin-bottom: 24px; align-items: flex-start; gap: 10px; line-height: 1.4;
        animation: alertSlide 0.3s ease; border: 1.5px solid transparent;
    }
    @keyframes alertSlide {
        from{opacity:0;transform:translateY(-10px);}
        to{opacity:1;transform:translateY(0);}
    }
    .alert.error { background: var(--error-bg); border-color: rgba(220,38,38,0.2); color: var(--error); }
    .alert.success { background: #f0fdf4; border-color: rgba(22,163,74,0.2); color: var(--success); }
    #loginAlertIcon { font-size: 16px; flex-shrink: 0; margin-top: 1px; }

    /* Button */
    .btn-login {
        width: 100%; padding: 14px; background: linear-gradient(135deg, var(--accent), #4f46e5);
        color: white; border: none; border-radius: 12px; font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 14.5px; font-weight: 700; cursor: pointer; transition: all 0.2s ease;
        margin-top: 10px; position: relative; overflow: hidden;
        box-shadow: 0 4px 14px var(--accent-glow);
    }
    .btn-login:hover:not(:disabled) {
        transform: translateY(-2px); box-shadow: 0 8px 24px rgba(37,99,235,0.3);
    }
    .btn-login:active:not(:disabled) { transform: translateY(0); box-shadow: 0 4px 10px rgba(37,99,235,0.2); }
    .btn-login:disabled { opacity: 0.7; cursor: not-allowed; box-shadow: none; transform: none; }

    .btn-spinner {
        display: none; width: 18px; height: 18px; border: 2.5px solid rgba(255,255,255,0.3);
        border-top-color: white; border-radius: 50%; animation: spin 0.7s linear infinite;
        margin: 0 auto;
    }
    @keyframes spin { to{transform:rotate(360deg);} }

    @media (max-width:768px) {
        .left-panel { display: none; }
        .right-panel { width: 100%; padding: 32px 24px; border-left: none; box-shadow: none; }
    }
</style>
</head>
<body>
<div class="bg-grid"></div>
<div class="bg-orb bg-orb-1"></div>
<div class="bg-orb bg-orb-2"></div>
<div class="page">
    <div class="left-panel">
        <div class="brand">
            </div>
        <h1 class="left-headline">Manage your<br>sales <span>smarter</span><br>than ever.</h1>
        <p class="left-sub">Your all-in-one platform for customers, products, and orders. Real-time insights, zero friction.</p>
        <div class="stats-row">
            <div class="stat"><span class="stat-num">∞</span><span class="stat-label">Unlimited Customers</span></div>
            <div class="stat"><span class="stat-num">24/7</span><span class="stat-label">Enterprise Uptime</span></div>
            <div class="stat"><span class="stat-num">⚡</span><span class="stat-label">Real-time Sync</span></div>
        </div>
    </div>
    <div class="right-panel">
        <div class="login-card">
            <h2 class="card-title">Welcome back</h2>
            <p class="card-sub">Sign in to your account to continue</p>

            <div class="alert" id="loginAlert">
                <span id="loginAlertIcon">⚠️</span>
                <span id="loginAlertMsg"></span>
            </div>

            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <div class="input-wrap">
                    <span class="input-icon">👤</span>
                    <input type="text" id="username" class="form-input" placeholder="Enter your username" autocomplete="username" spellcheck="false">
                </div>
                <span class="field-error" id="errUsername"></span>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <div class="input-wrap">
                    <span class="input-icon">🔒</span>
                    <input type="password" id="password" class="form-input" placeholder="Enter your password" autocomplete="current-password">
                    <button class="pw-toggle" id="pwToggle" type="button" tabindex="-1" aria-label="Toggle password visibility">👁</button>
                </div>
                <span class="field-error" id="errPassword"></span>
            </div>

            <button class="btn-login" id="loginBtn" type="button">
                <span id="btnText">Sign In</span>
                <div class="btn-spinner" id="btnSpinner"></div>
            </button>
        </div>
    </div>
</div>

<script>
(function () {
    // Token validation on load
    var existingToken = sessionStorage.getItem('token');
    if (existingToken && existingToken.trim() !== '') {
        fetch('/api/validate', {
            method: 'GET',
            headers: { 'Authorization': 'Bearer ' + existingToken }
        })
        .then(function(res) {
            if (res.ok) {
                window.location.href = '/pages/dashboard';
            } else {
                sessionStorage.removeItem('token');
                sessionStorage.removeItem('refreshToken');
            }
        })
        .catch(function() {
            sessionStorage.removeItem('token');
            sessionStorage.removeItem('refreshToken');
        });
        return;
    }

    // DOM Elements
    var usernameInput = document.getElementById('username');
    var passwordInput = document.getElementById('password');
    var loginBtn      = document.getElementById('loginBtn');
    var btnText       = document.getElementById('btnText');
    var btnSpinner    = document.getElementById('btnSpinner');
    var loginAlert    = document.getElementById('loginAlert');
    var loginAlertMsg = document.getElementById('loginAlertMsg');
    var pwToggle      = document.getElementById('pwToggle');

    // Password visibility toggle
    pwToggle.addEventListener('click', function () {
        var isPassword = passwordInput.type === 'password';
        passwordInput.type = isPassword ? 'text' : 'password';
        pwToggle.textContent = isPassword ? '🙈' : '👁';
        pwToggle.setAttribute('aria-label', (isPassword ? 'Hide' : 'Show') + ' password');
    });

    // Input event listeners
    usernameInput.addEventListener('input', function () {
        clearFieldError('username', 'errUsername');
        hideAlert();
    });

    passwordInput.addEventListener('input', function () {
        clearFieldError('password', 'errPassword');
        hideAlert();
    });

    [usernameInput, passwordInput].forEach(function (el) {
        el.addEventListener('keydown', function (e) {
            if (e.key === 'Enter') handleLogin();
        });
    });

    loginBtn.addEventListener('click', handleLogin);

    // Main login handler
    function handleLogin() {
        hideAlert();

        var username = usernameInput.value.trim();
        var password = passwordInput.value;
        var valid = true;

        if (!username) {
            showFieldError('username', 'errUsername', 'Username is required');
            valid = false;
        }
        if (!password) {
            showFieldError('password', 'errPassword', 'Password is required');
            valid = false;
        }
        if (!valid) return;

        setLoading(true);

        fetch('/auth/login', {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ username: username, password: password })
        })
        .then(function (res) {
            if (!res.ok) {
                return res.json().then(function (data) {
                    throw new Error(data.message || data.error || getErrorMessage(res.status));
                }).catch(function () {
                    throw new Error(getErrorMessage(res.status));
                });
            }
            return res.json();
        })
        .then(function (data) {
            if (!data.accessToken) throw new Error('No token received from server.');

            sessionStorage.setItem('token', data.accessToken);
            if (data.refreshToken) sessionStorage.setItem('refreshToken', data.refreshToken);

            showAlert('success', '✅', 'Login successful! Redirecting…');

            setTimeout(function () {
                window.location.href = '/pages/dashboard';
            }, 800);
        })
        .catch(function (err) {
            setLoading(false);
            showAlert('error', '⚠️', err.message || 'Login failed. Please try again.');
            shake();
        });
    }

    // Utility functions
    function shake() {
        var card = document.querySelector('.login-card');
        card.style.transform = 'translateX(8px)';
        setTimeout(function () { card.style.transform = 'translateX(-8px)'; }, 80);
        setTimeout(function () { card.style.transform = 'translateX(4px)';  }, 160);
        setTimeout(function () { card.style.transform = 'translateX(-2px)';  }, 240);
        setTimeout(function () { card.style.transform = 'translateX(0)';    }, 320);
    }

    function setLoading(on) {
        loginBtn.disabled        = on;
        btnText.style.display    = on ? 'none'  : 'block';
        btnSpinner.style.display = on ? 'block' : 'none';
    }

    function showFieldError(inputId, errId, msg) {
        document.getElementById(inputId).classList.add('error');
        var el = document.getElementById(errId);
        el.textContent = msg;
        el.style.display = 'block';
    }

    function clearFieldError(inputId, errId) {
        document.getElementById(inputId).classList.remove('error');
        document.getElementById(errId).style.display = 'none';
    }

    function showAlert(type, icon, msg) {
        loginAlert.className = 'alert ' + type;
        document.getElementById('loginAlertIcon').textContent = icon;
        loginAlertMsg.textContent = msg;
        loginAlert.style.display = 'flex';
    }

    function hideAlert() {
        loginAlert.style.display = 'none';
        loginAlert.className = 'alert';
    }

    function getErrorMessage(status) {
        switch (status) {
            case 401: return 'Invalid username or password.';
            case 403: return 'Access denied.';
            case 404: return 'User not found.';
            case 500: return 'Server error. Please try again later.';
            default:  return 'Login failed. Please try again.';
        }
    }
})();
</script>
</body>
</html>