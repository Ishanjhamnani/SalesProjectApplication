<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login — SalesProject</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
        --bg:#0a0f1e; --panel:#0f172a; --border:#1e293b; --accent:#3b82f6; --accent-h:#2563eb;
        --accent-glow:rgba(59,130,246,0.35); --text:#f1f5f9; --muted:#94a3b8;
        --error:#ef4444; --error-bg:rgba(239,68,68,0.1); --success:#22c55e;
    }
    html, body { height:100%; font-family:'DM Sans',sans-serif; background:var(--bg); color:var(--text); overflow:hidden; }

    /* Animated background grid */
    .bg-grid {
        position:fixed; inset:0;
        background-image:linear-gradient(rgba(59,130,246,0.03) 1px, transparent 1px),
                        linear-gradient(90deg, rgba(59,130,246,0.03) 1px, transparent 1px);
        background-size:48px 48px;
        z-index:0;
        animation:gridFloat 20s linear infinite;
    }
    @keyframes gridFloat { 0%{transform:translateY(0);} 100%{transform:translateY(48px);} }

    /* Enhanced orbs */
    .bg-orb {
        position:fixed; border-radius:50%; filter:blur(90px); z-index:0;
        animation:drift 15s ease-in-out infinite alternate;
    }
    .bg-orb-1 {
        width:600px; height:600px;
        background:radial-gradient(circle, rgba(59,130,246,0.2) 0%, rgba(99,102,241,0.1) 50%, transparent 80%);
        top:-150px; left:-120px;
    }
    .bg-orb-2 {
        width:500px; height:500px;
        background:radial-gradient(circle, rgba(139,92,246,0.15) 0%, rgba(59,130,246,0.05) 60%, transparent 85%);
        bottom:-120px; right:-100px; animation-delay:-7s;
    }
    @keyframes drift {
        0%{transform:translate(0,0) scale(1);}
        100%{transform:translate(40px,30px) scale(1.1);}
    }

    .page { position:relative; z-index:1; display:flex; height:100vh; }

    /* Enhanced left panel */
    .left-panel {
        flex:1; display:flex; flex-direction:column; justify-content:center; padding:60px;
        border-right:1px solid var(--border); position:relative; overflow:hidden;
        backdrop-filter:blur(10px);
    }
    .left-panel::before {
        content:''; position:absolute; inset:0;
        background:linear-gradient(135deg, rgba(59,130,246,0.08) 0%, transparent 70%);
        pointer-events:none;
    }
    .left-panel::after {
        content:''; position:absolute; bottom:0; left:0; right:0; height:1px;
        background:linear-gradient(90deg, transparent, var(--accent), transparent);
    }

    .brand {
        font-family:'Syne',sans-serif; font-size:14px; font-weight:700;
        letter-spacing:0.15em; text-transform:uppercase; color:var(--accent);
        margin-bottom:48px; display:flex; align-items:center; gap:12px;
    }
    .brand-dot {
        width:10px; height:10px; background:var(--accent); border-radius:50%;
        box-shadow:0 0 15px var(--accent-glow); animation:pulse 2.5s ease-in-out infinite;
        position:relative;
    }
    .brand-dot::after {
        content:''; position:absolute; inset:-2px; border-radius:50%;
        border:1px solid rgba(59,130,246,0.3); animation:ripple 2s ease-out infinite;
    }
    @keyframes ripple { 0%{transform:scale(1); opacity:1;} 100%{transform:scale(2); opacity:0;} }
    @keyframes pulse { 0%,100%{opacity:1;transform:scale(1);} 50%{opacity:0.7;transform:scale(0.9);} }

    .left-headline {
        font-family:'Syne',sans-serif; font-size:clamp(42px,5vw,56px); font-weight:800;
        line-height:1.1; letter-spacing:-0.02em; margin-bottom:20px;
    }
    .left-headline span {
        background:linear-gradient(135deg, #93c5fd, #3b82f6, #8b5cf6);
        -webkit-background-clip:text; -webkit-text-fill-color:transparent;
        background-clip:text; background-size:200% 200%; animation:gradientShift 6s ease infinite;
    }
    @keyframes gradientShift { 0%,100%{background-position:0% 50%;} 50%{background-position:100% 50%;} }

    .left-sub {
        font-size:17px; color:var(--muted); line-height:1.7; max-width:420px;
        margin-bottom:60px; text-shadow:0 2px 5px rgba(0,0,0,0.2);
    }

    /* Enhanced stats */
    .stats-row { display:flex; gap:48px; }
    .stat { display:flex; flex-direction:column; gap:6px; position:relative; }
    .stat:not(:last-child)::after {
        content:''; position:absolute; right:-24px; top:50%; transform:translateY(-50%);
        width:1px; height:30px; background:linear-gradient(180deg, transparent, var(--border), transparent);
    }
    .stat-num {
        font-family:'Syne',sans-serif; font-size:32px; font-weight:700;
        background:linear-gradient(180deg, var(--text), var(--muted));
        -webkit-background-clip:text; -webkit-text-fill-color:transparent;
    }
    .stat-label { font-size:13px; font-weight:500; color:var(--muted); text-transform:uppercase; letter-spacing:0.1em; }

    /* Enhanced right panel */
    .right-panel {
        width:480px; flex-shrink:0; display:flex; align-items:center; justify-content:center;
        padding:40px; background:rgba(15,23,42,0.7); backdrop-filter:blur(20px);
        border-left:1px solid rgba(59,130,246,0.15);
        box-shadow:-10px 0 30px rgba(0,0,0,0.3);
    }

    .login-card {
        width:100%; animation:slideUp 0.6s cubic-bezier(0.16,1,0.3,1) both;
        transition:transform 0.2s ease;
    }
    @keyframes slideUp {
        from{opacity:0;transform:translateY(30px);}
        to{opacity:1;transform:translateY(0);}
    }

    .card-title {
        font-family:'Syne',sans-serif; font-size:28px; font-weight:700;
        margin-bottom:8px; letter-spacing:-0.01em;
        background:linear-gradient(135deg, var(--text), #cbd5e1);
        -webkit-background-clip:text; -webkit-text-fill-color:transparent;
    }
    .card-sub { font-size:15px; color:var(--muted); margin-bottom:40px; }

    /* Enhanced form elements */
    .form-group { margin-bottom:24px; }
    .form-label {
        display:block; font-size:12px; font-weight:600; color:var(--muted);
        text-transform:uppercase; letter-spacing:0.08em; margin-bottom:8px;
        transition:color 0.2s;
    }
    .form-group:focus-within .form-label { color:var(--accent); }

    .input-wrap { position:relative; }
    .input-icon {
        position:absolute; left:16px; top:50%; transform:translateY(-50%);
        color:var(--muted); font-size:18px; pointer-events:none;
        transition:color 0.2s, transform 0.2s;
    }
    .input-wrap:focus-within .input-icon {
        color:var(--accent); transform:translateY(-50%) scale(1.1);
    }

    .form-input {
        width:100%; padding:14px 16px 14px 48px;
        background:rgba(30,41,59,0.5); border:1px solid var(--border);
        border-radius:12px; color:var(--text); font-family:'DM Sans',sans-serif;
        font-size:15px; outline:none; transition:all 0.2s ease;
    }
    .form-input::placeholder { color:#334155; font-weight:300; }
    .form-input:hover { background:rgba(30,41,59,0.7); border-color:#334155; }
    .form-input:focus {
        border-color:var(--accent); background:rgba(37,99,235,0.08);
        box-shadow:0 0 0 4px var(--accent-glow); transform:translateY(-1px);
    }

    .form-input.error {
        border-color:var(--error);
        box-shadow:0 0 0 3px rgba(239,68,68,0.15);
        animation:shake 0.3s ease;
    }
    @keyframes shake {
        0%,100%{transform:translateX(0);}
        25%{transform:translateX(-5px);}
        75%{transform:translateX(5px);}
    }

    .pw-toggle {
        position:absolute; right:16px; top:50%; transform:translateY(-50%);
        background:none; border:none; cursor:pointer; color:var(--muted);
        font-size:18px; padding:5px; line-height:1; transition:all 0.2s;
        border-radius:6px;
    }
    .pw-toggle:hover {
        color:var(--text); background:rgba(255,255,255,0.05);
        transform:translateY(-50%) scale(1.1);
    }
    .pw-toggle:active { transform:translateY(-50%) scale(0.95); }

    .field-error {
        display:none; font-size:12px; color:var(--error); margin-top:6px;
        padding-left:2px; font-weight:500;
    }

    /* Enhanced alerts */
    .alert {
        display:none; padding:14px 16px; border-radius:12px; font-size:14px;
        margin-bottom:24px; align-items:center; gap:12px;
        border:1px solid transparent; animation:alertSlide 0.3s ease;
    }
    @keyframes alertSlide {
        from{opacity:0;transform:translateY(-10px);}
        to{opacity:1;transform:translateY(0);}
    }
    .alert.error  {
        display:flex; background:var(--error-bg); border-color:rgba(239,68,68,0.25);
        color:#fca5a5;
    }
    .alert.success{
        display:flex; background:rgba(34,197,94,0.1); border-color:rgba(34,197,94,0.25);
        color:#86efac;
    }
    #loginAlertIcon { font-size:18px; }

    /* Enhanced button */
    .btn-login {
        width:100%; padding:15px; background:linear-gradient(135deg, var(--accent), #4f46e5);
        color:white; border:none; border-radius:12px; font-family:'Syne',sans-serif;
        font-size:16px; font-weight:600; cursor:pointer; transition:all 0.2s ease;
        margin-top:16px; letter-spacing:0.02em; position:relative; overflow:hidden;
    }
    .btn-login::before {
        content:''; position:absolute; top:0; left:-100%; width:100%; height:100%;
        background:linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition:left 0.5s;
    }
    .btn-login:hover:not(:disabled) {
        transform:translateY(-2px); box-shadow:0 8px 25px var(--accent-glow);
    }
    .btn-login:hover:not(:disabled)::before { left:100%; }
    .btn-login:active:not(:disabled) { transform:translateY(0); }
    .btn-login:disabled { opacity:0.6; cursor:not-allowed; }

    .btn-spinner {
        display:none; width:20px; height:20px; border:2px solid rgba(255,255,255,0.3);
        border-top-color:white; border-radius:50%; animation:spin 0.7s linear infinite;
        margin:0 auto;
    }
    @keyframes spin { to{transform:rotate(360deg);} }

    @media (max-width:768px) {
        .left-panel{display:none;}
        .right-panel{width:100%;padding:32px 24px;}
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
            <div class="brand-dot"></div>
            <span>SalesProject</span>
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