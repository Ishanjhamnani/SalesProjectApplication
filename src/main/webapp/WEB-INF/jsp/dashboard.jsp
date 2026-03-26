<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard — SalesPanel</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
:root {
  --bg: #f0f4fa;
  --surface: #ffffff;
  --border: rgba(99,115,155,0.12);
  --blue: #2563eb; --blue-soft: #eff4ff;
  --indigo: #4f46e5;
  --teal: #0d9488; --teal-soft: #f0fdfb;
  --orange: #ea580c; --orange-soft: #fff7ed;
  --red: #dc2626; --red-soft: #fff1f1;
  --text: #0f172a; --text-2: #334155; --text-3: #64748b; --text-4: #94a3b8;
  --radius: 14px;
  --shadow: 0 1px 3px rgba(15,23,42,0.06), 0 4px 16px rgba(15,23,42,0.06);
  --shadow-md: 0 4px 24px rgba(15,23,42,0.10);
}

* { box-sizing: border-box; margin: 0; padding: 0; }
body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: var(--bg);
    color: var(--text);
    min-height: 100vh;
    overflow-x: hidden;
}

/* ── APP SHELL ── */
.app-layout { display: flex; min-height: 100vh; }
.main { flex: 1; min-width: 0; display: flex; flex-direction: column; background: var(--bg); }
.content { padding: 32px 40px; flex: 1; }

/* PAGE HEADER */
.page-header { margin-bottom: 32px; }
.breadcrumb { display: flex; align-items: center; gap: 6px; font-size: 12.5px; color: var(--text-4); margin-bottom: 6px; font-weight: 600; }
.breadcrumb span { color: var(--text-3); }
.page-title { font-size: 28px; font-weight: 800; color: var(--text); letter-spacing: -0.04em; line-height: 1.2; }
.page-subtitle { font-size: 14px; color: var(--text-3); margin-top: 4px; }

/* STAT CARDS */
.stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 32px; }
.stat-card {
    background: var(--surface); border-radius: var(--radius); padding: 24px;
    box-shadow: var(--shadow); border: 1px solid var(--border);
    position: relative; overflow: hidden; transition: transform 0.2s, box-shadow 0.2s;
}
.stat-card:hover { transform: translateY(-3px); box-shadow: var(--shadow-md); }
.stat-card::before {
    content: ''; position: absolute; top: 0; right: 0;
    width: 120px; height: 120px; border-radius: 50%; opacity: 0.04;
}
.stat-card.blue::before  { background: var(--blue);   transform: translate(30px, -40px); }
.stat-card.orange::before{ background: var(--orange); transform: translate(30px, -40px); }
.stat-card.teal::before  { background: var(--teal);   transform: translate(30px, -40px); }
.stat-card.red::before   { background: var(--red);    transform: translate(30px, -40px); }

.stat-icon-wrap {
    width: 44px; height: 44px; border-radius: 12px; display: flex;
    align-items: center; justify-content: center; font-size: 20px; margin-bottom: 16px;
}
.blue  .stat-icon-wrap { background: var(--blue-soft);   color: var(--blue); }
.orange.stat-icon-wrap { background: var(--orange-soft); color: var(--orange); }
.teal  .stat-icon-wrap { background: var(--teal-soft);   color: var(--teal); }
.red   .stat-icon-wrap { background: var(--red-soft);    color: var(--red); }

.stat-label { font-size: 12px; font-weight: 700; color: var(--text-3); letter-spacing: 0.05em; text-transform: uppercase; margin-bottom: 8px; }
.stat-value { font-size: 32px; font-weight: 800; color: var(--text); letter-spacing: -0.04em; line-height: 1; font-family: 'JetBrains Mono', monospace; }
.stat-sub   { font-size: 12.5px; color: var(--text-4); margin-top: 10px; font-weight: 500; }
.stat-up      { color: #16a34a; font-weight: 700; }
.stat-down    { color: var(--red); font-weight: 700; }
.stat-neutral { color: var(--orange); font-weight: 700; }

/* SKELETON LOADER */
.skeleton {
    display: inline-block;
    background: linear-gradient(90deg, #e2e8f0 25%, #f1f5f9 50%, #e2e8f0 75%);
    background-size: 200% 100%;
    animation: shimmer 1.4s infinite;
    border-radius: 6px;
}
@keyframes shimmer { 0% { background-position: 200% 0; } 100% { background-position: -200% 0; } }
.skeleton-value { width: 100px; height: 32px; }
.skeleton-sub   { width: 140px; height: 14px; margin-top: 10px; }
</style>
</head>
<body>

<div class="app-layout">
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp"/>

    <div class="main">
        <div class="content">

            <div class="page-header">
                <div class="breadcrumb">Overview <span>›</span> Dashboard</div>
                <h1 class="page-title">Welcome back, Admin 👋</h1>
                <p class="page-subtitle">Here's what's happening with your store today.</p>
            </div>

            <div class="stats-grid">

                <!-- Revenue -->
                <div class="stat-card blue">
                    <div class="stat-icon-wrap">💰</div>
                    <div class="stat-label">Total Revenue (Month)</div>
                    <div class="stat-value" id="valRevenue">
                        <span class="skeleton skeleton-value"></span>
                    </div>
                    <div class="stat-sub" id="subRevenue">
                        <span class="skeleton skeleton-sub"></span>
                    </div>
                </div>

                <!-- Pending Orders -->
                <div class="stat-card orange">
                    <div class="stat-icon-wrap">⏳</div>
                    <div class="stat-label">Pending Orders</div>
                    <div class="stat-value" id="valPending">
                        <span class="skeleton skeleton-value"></span>
                    </div>
                    <div class="stat-sub" id="subPending">
                        <span class="skeleton skeleton-sub"></span>
                    </div>
                </div>

                <!-- Active Customers -->
                <div class="stat-card teal">
                    <div class="stat-icon-wrap">👥</div>
                    <div class="stat-label">Active Customers</div>
                    <div class="stat-value" id="valCustomers">
                        <span class="skeleton skeleton-value"></span>
                    </div>
                    <div class="stat-sub" id="subCustomers">
                        <span class="skeleton skeleton-sub"></span>
                    </div>
                </div>

                <!-- Low Stock -->
                <div class="stat-card red">
                    <div class="stat-icon-wrap">⚠️</div>
                    <div class="stat-label">Low Stock Alerts</div>
                    <div class="stat-value" id="valStock">
                        <span class="skeleton skeleton-value"></span>
                    </div>
                    <div class="stat-sub" id="subStock">
                        <span class="skeleton skeleton-sub"></span>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>

<script>
$(document).ready(function () {

    $.ajax({
        url: '/api/dashboard-stats',
        type: 'GET',
        success: function (res) {

            // ── Revenue ──────────────────────────────────────────────
            $('#valRevenue').text(res.revenue ?? '₹0');
            if (res.revenueGrowth) {
                let isUp  = res.revenueGrowth.includes('+');
                let cls   = isUp ? 'stat-up' : 'stat-down';
                let arrow = isUp ? '↑' : '↓';
                $('#subRevenue').html('<span class="' + cls + '">' + arrow + ' ' + res.revenueGrowth + '</span> vs last month');
            } else {
                $('#subRevenue').text('Current month earnings');
            }

            // ── Pending Orders ───────────────────────────────────────
            $('#valPending').text(res.pendingOrders ?? 0);
            if (res.pendingOrders > 0) {
                $('#subPending').html('<span class="stat-neutral">Requires attention</span>');
            } else {
                $('#subPending').html('<span class="stat-up">All caught up!</span>');
            }

            // ── Active Customers ─────────────────────────────────────
            $('#valCustomers').text(res.activeCustomers ?? 0);
            if (res.customerGrowth) {
                let isUp  = res.customerGrowth.includes('+');
                let cls   = isUp ? 'stat-up' : 'stat-down';
                let arrow = isUp ? '↑' : '↓';
                $('#subCustomers').html('<span class="' + cls + '">' + arrow + ' ' + res.customerGrowth + '</span> vs last month');
            } else {
                $('#subCustomers').text('Purchased recently');
            }

            // ── Low Stock ────────────────────────────────────────────
            $('#valStock').text(res.lowStockCount ?? 0);
            if (res.lowStockCount > 0) {
                $('#subStock').html('<span class="stat-down">' + res.lowStockCount + ' items critical</span>');
            } else {
                $('#subStock').html('<span class="stat-up">Inventory looks good</span>');
            }
        },

        error: function () {
            $('#valRevenue').text('—');
            $('#valPending').text('—');
            $('#valCustomers').text('—');
            $('#valStock').text('—');
            $('#subRevenue, #subPending, #subCustomers, #subStock')
                .html('<span class="stat-down">Failed to load</span>');
        }
    });

});
</script>
</body>
</html>
