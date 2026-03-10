<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Customers — SalesPanel</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<style>
:root {
    --bg:           #080c14;
    --surface:      #0d1320;
    --surface-2:    #111827;
    --border:       rgba(255,255,255,0.06);
    --border-2:     rgba(255,255,255,0.10);
    --accent:       #3b82f6;
    --accent-glow:  rgba(59,130,246,0.15);
    --accent-dark:  #1d4ed8;
    --danger:       #ef4444;
    --danger-glow:  rgba(239,68,68,0.12);
    --success:      #22c55e;
    --text:         #f1f5f9;
    --text-dim:     rgba(241,245,249,0.55);
    --text-muted:   rgba(241,245,249,0.30);
    --radius:       10px;
    --radius-sm:    6px;
}

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    font-family: 'Syne', sans-serif;
    background: var(--bg);
    color: var(--text);
    min-height: 100vh;
    overflow-x: hidden;
}

.container { display: flex; min-height: 100vh; }

/* ── Content ── */
.content {
    flex: 1;
    padding: 36px 40px;
    min-width: 0;
    background:
        radial-gradient(ellipse 60% 40% at 80% -10%, rgba(59,130,246,0.07) 0%, transparent 60%),
        var(--bg);
}

/* ── Page Header ── */
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 32px;
}

.page-title-group {}

.page-eyebrow {
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.14em;
    color: var(--accent);
    text-transform: uppercase;
    margin-bottom: 4px;
}

.page-title {
    font-size: 28px;
    font-weight: 800;
    color: var(--text);
    letter-spacing: -0.03em;
    line-height: 1;
}

.page-subtitle {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    color: var(--text-muted);
    margin-top: 6px;
    letter-spacing: 0.04em;
}

.btn-primary {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 20px;
    background: var(--accent);
    color: white;
    border: none;
    border-radius: var(--radius-sm);
    cursor: pointer;
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 13px;
    letter-spacing: 0.02em;
    transition: all 0.18s ease;
    position: relative;
    overflow: hidden;
}

.btn-primary::after {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(to bottom, rgba(255,255,255,0.1), transparent);
    pointer-events: none;
}

.btn-primary:hover {
    background: var(--accent-dark);
    transform: translateY(-1px);
    box-shadow: 0 6px 20px rgba(59,130,246,0.35);
}

.btn-primary:active { transform: translateY(0); }

/* ── Stats bar ── */
.stats-bar {
    display: flex;
    gap: 1px;
    margin-bottom: 28px;
    background: var(--border);
    border-radius: var(--radius);
    overflow: hidden;
    border: 1px solid var(--border);
}

.stat-item {
    flex: 1;
    padding: 16px 20px;
    background: var(--surface);
    display: flex;
    flex-direction: column;
    gap: 2px;
}

.stat-item:first-child { border-radius: var(--radius) 0 0 var(--radius); }
.stat-item:last-child  { border-radius: 0 var(--radius) var(--radius) 0; }

.stat-label {
    font-family: 'DM Mono', monospace;
    font-size: 9px;
    letter-spacing: 0.12em;
    color: var(--text-muted);
    text-transform: uppercase;
}

.stat-value {
    font-size: 22px;
    font-weight: 800;
    color: var(--text);
    letter-spacing: -0.03em;
    line-height: 1;
}

.stat-value.accent { color: var(--accent); }

/* ── Table wrapper ── */
.table-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    overflow: hidden;
}

/* DataTables overrides */
.dataTables_wrapper {
    padding: 0;
    color: var(--text);
}

.dataTables_wrapper .dataTables_length,
.dataTables_wrapper .dataTables_filter,
.dataTables_wrapper .dataTables_info,
.dataTables_wrapper .dataTables_paginate {
    padding: 16px 20px;
}

.dataTables_wrapper .dataTables_length,
.dataTables_wrapper .dataTables_filter {
    display: flex;
    align-items: center;
    border-bottom: 1px solid var(--border);
    background: var(--surface-2);
}

.dataTables_wrapper .dataTables_length { justify-content: flex-start; }
.dataTables_wrapper .dataTables_filter { justify-content: flex-end; margin-left: auto; }

/* Top controls row */
div.dataTables_wrapper div.dataTables_length label,
div.dataTables_wrapper div.dataTables_filter label {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    color: var(--text-dim);
    letter-spacing: 0.04em;
    display: flex;
    align-items: center;
    gap: 8px;
}

div.dataTables_wrapper div.dataTables_length select {
    background: var(--bg);
    border: 1px solid var(--border-2);
    color: var(--text);
    border-radius: var(--radius-sm);
    padding: 4px 8px;
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    outline: none;
}

div.dataTables_wrapper div.dataTables_filter input {
    background: var(--bg);
    border: 1px solid var(--border-2);
    color: var(--text);
    border-radius: var(--radius-sm);
    padding: 7px 12px;
    font-family: 'DM Mono', monospace;
    font-size: 12px;
    outline: none;
    width: 220px;
    transition: border-color 0.18s;
}

div.dataTables_wrapper div.dataTables_filter input:focus {
    border-color: var(--accent);
    box-shadow: 0 0 0 3px var(--accent-glow);
}

div.dataTables_wrapper div.dataTables_filter input::placeholder { color: var(--text-muted); }

/* Table */
table.dataTable {
    border-collapse: collapse !important;
    width: 100% !important;
    margin: 0 !important;
}

table.dataTable thead th {
    background: var(--surface-2);
    color: var(--text-muted);
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    font-weight: 500;
    padding: 12px 16px;
    border-bottom: 1px solid var(--border);
    border-top: none;
    white-space: nowrap;
}

table.dataTable thead th.sorting,
table.dataTable thead th.sorting_asc,
table.dataTable thead th.sorting_desc {
    background: var(--surface-2);
}

table.dataTable tbody tr {
    background: var(--surface);
    transition: background 0.12s;
}

table.dataTable tbody tr:hover { background: rgba(59,130,246,0.04); }

table.dataTable tbody td {
    padding: 13px 16px;
    border-bottom: 1px solid var(--border);
    font-size: 13.5px;
    color: var(--text-dim);
    vertical-align: middle;
}

table.dataTable tbody tr:last-child td { border-bottom: none; }

/* Sr. No. */
table.dataTable tbody td:first-child {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    color: var(--text-muted);
    letter-spacing: 0.04em;
}

/* Full Name */
table.dataTable tbody td:nth-child(2) {
    font-weight: 700;
    color: var(--text);
    font-size: 13.5px;
}

/* Email */
table.dataTable tbody td:nth-child(3) {
    font-family: 'DM Mono', monospace;
    font-size: 11.5px;
    color: var(--text-dim);
}

/* Phone */
table.dataTable tbody td:nth-child(4) {
    font-family: 'DM Mono', monospace;
    font-size: 12px;
}

/* Address cell */
#customersTable td.address-cell {
    max-width: 180px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 12px;
    color: var(--text-muted);
}

/* Bottom controls */
div.dataTables_wrapper div.dataTables_info {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    color: var(--text-muted);
    border-top: 1px solid var(--border);
    background: var(--surface-2);
}

div.dataTables_wrapper div.dataTables_paginate {
    border-top: 1px solid var(--border);
    background: var(--surface-2);
}

div.dataTables_wrapper div.dataTables_paginate .paginate_button {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    color: var(--text-dim) !important;
    border-radius: var(--radius-sm) !important;
    border: 1px solid transparent !important;
    padding: 5px 10px !important;
    transition: all 0.15s !important;
}

div.dataTables_wrapper div.dataTables_paginate .paginate_button:hover {
    background: var(--accent-glow) !important;
    border-color: rgba(59,130,246,0.2) !important;
    color: var(--accent) !important;
}

div.dataTables_wrapper div.dataTables_paginate .paginate_button.current,
div.dataTables_wrapper div.dataTables_paginate .paginate_button.current:hover {
    background: var(--accent) !important;
    border-color: var(--accent) !important;
    color: white !important;
}

div.dataTables_wrapper div.dataTables_paginate .paginate_button.disabled,
div.dataTables_wrapper div.dataTables_paginate .paginate_button.disabled:hover {
    color: var(--text-muted) !important;
}

/* ── Action menu ── */
.edit-icon {
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 28px;
    height: 28px;
    border-radius: 6px;
    background: rgba(255,255,255,0.05);
    border: 1px solid var(--border);
    font-size: 14px;
    transition: all 0.15s;
    user-select: none;
    color: var(--text-dim);
}

.edit-icon:hover {
    background: var(--accent-glow);
    border-color: rgba(59,130,246,0.3);
    color: var(--accent);
}

.action-menu {
    position: fixed;
    background: #0d1320;
    border: 1px solid var(--border-2);
    border-radius: var(--radius-sm);
    display: none;
    z-index: 9999;
    min-width: 150px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.5);
    overflow: hidden;
}

.action-menu div {
    padding: 11px 16px;
    cursor: pointer;
    color: var(--text-dim);
    font-size: 13px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: background 0.12s;
}

.action-menu div:hover { background: rgba(255,255,255,0.05); color: var(--text); }
.action-menu .delete-option { color: rgba(248, 113, 113, 0.7); }
.action-menu .delete-option:hover { background: var(--danger-glow); color: #f87171; }

/* ── Toast ── */
#toast-container {
    position: fixed;
    top: 24px;
    right: 24px;
    z-index: 99999;
    display: flex;
    flex-direction: column;
    gap: 10px;
    pointer-events: none;
}

.toast {
    display: flex;
    align-items: center;
    gap: 12px;
    min-width: 280px;
    max-width: 380px;
    padding: 14px 16px;
    border-radius: var(--radius);
    font-size: 13px;
    font-weight: 600;
    color: white;
    box-shadow: 0 8px 32px rgba(0,0,0,0.4);
    pointer-events: all;
    opacity: 0;
    transform: translateX(40px);
    transition: opacity 0.3s ease, transform 0.3s ease;
    border: 1px solid rgba(255,255,255,0.1);
    backdrop-filter: blur(12px);
}

.toast.show { opacity: 1; transform: translateX(0); }
.toast.hide { opacity: 0; transform: translateX(40px); }
.toast.success { background: rgba(22,163,74,0.95); }
.toast.error   { background: rgba(220,38,38,0.95); }
.toast.info    { background: rgba(37,99,235,0.95); }
.toast-icon    { font-size: 16px; flex-shrink: 0; }
.toast-msg     { flex: 1; line-height: 1.4; }
.toast-close   { cursor: pointer; opacity: 0.7; font-size: 15px; flex-shrink: 0; background: none; border: none; color: white; padding: 0; }
.toast-close:hover { opacity: 1; }

/* ── Confirm dialog ── */
#confirm-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.7);
    z-index: 20000;
    align-items: center;
    justify-content: center;
    backdrop-filter: blur(4px);
}
#confirm-overlay.active { display: flex; }

#confirm-box {
    background: var(--surface);
    border: 1px solid var(--border-2);
    border-radius: 14px;
    padding: 32px;
    width: 360px;
    max-width: 92vw;
    box-shadow: 0 24px 80px rgba(0,0,0,0.6);
    text-align: center;
    animation: popIn 0.2s cubic-bezier(0.34,1.56,0.64,1);
}

@keyframes popIn {
    from { transform: scale(0.9); opacity: 0; }
    to   { transform: scale(1);   opacity: 1; }
}

#confirm-box .confirm-icon { font-size: 36px; margin-bottom: 14px; }

#confirm-box h4 {
    font-size: 17px;
    font-weight: 800;
    color: var(--text);
    margin-bottom: 8px;
    letter-spacing: -0.02em;
}

#confirm-box p {
    font-size: 13px;
    color: var(--text-muted);
    line-height: 1.6;
    margin-bottom: 24px;
}

.confirm-btns { display: flex; gap: 10px; }

.btn-confirm-cancel {
    flex: 1; padding: 11px;
    background: rgba(255,255,255,0.06);
    color: var(--text-dim);
    border: 1px solid var(--border);
    border-radius: var(--radius-sm);
    cursor: pointer;
    font-family: 'Syne', sans-serif;
    font-size: 13px; font-weight: 700;
    transition: all 0.15s;
}
.btn-confirm-cancel:hover { background: rgba(255,255,255,0.10); color: var(--text); }

.btn-confirm-ok {
    flex: 1; padding: 11px;
    background: var(--danger);
    color: white;
    border: none;
    border-radius: var(--radius-sm);
    cursor: pointer;
    font-family: 'Syne', sans-serif;
    font-size: 13px; font-weight: 700;
    transition: all 0.15s;
}
.btn-confirm-ok:hover { background: #dc2626; box-shadow: 0 4px 14px rgba(239,68,68,0.4); }

/* ── Modals ── */
.modal-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.7);
    z-index: 10000;
    align-items: center;
    justify-content: center;
    backdrop-filter: blur(4px);
}
.modal-overlay.active { display: flex; }

.modal-content {
    background: var(--surface);
    border: 1px solid var(--border-2);
    color: var(--text);
    border-radius: 14px;
    padding: 28px;
    width: 480px;
    max-width: 95vw;
    position: relative;
    max-height: 90vh;
    overflow-y: auto;
    animation: popIn 0.2s cubic-bezier(0.34,1.56,0.64,1);
}

.modal-content::-webkit-scrollbar { width: 4px; }
.modal-content::-webkit-scrollbar-track { background: transparent; }
.modal-content::-webkit-scrollbar-thumb { background: var(--border-2); border-radius: 2px; }

.modal-content h3 {
    margin: 0 0 22px 0;
    font-size: 17px;
    font-weight: 800;
    letter-spacing: -0.02em;
    color: var(--text);
    border-bottom: 1px solid var(--border);
    padding-bottom: 14px;
}

.modal-content label {
    display: block;
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    font-weight: 500;
    color: var(--text-muted);
    margin-bottom: 5px;
    text-transform: uppercase;
    letter-spacing: 0.10em;
}

.modal-content input,
.modal-content select {
    width: 100%;
    padding: 10px 13px;
    margin-bottom: 4px;
    border-radius: var(--radius-sm);
    border: 1px solid var(--border-2);
    font-size: 13.5px;
    color: var(--text);
    background: var(--bg);
    font-family: 'Syne', sans-serif;
    transition: border-color 0.15s, box-shadow 0.15s;
    appearance: none;
    -webkit-appearance: none;
    outline: none;
}

.modal-content input::placeholder { color: var(--text-muted); }

.modal-content input:focus,
.modal-content select:focus {
    border-color: var(--accent);
    box-shadow: 0 0 0 3px var(--accent-glow);
}

.modal-content input.input-error,
.modal-content select.input-error {
    border-color: var(--danger) !important;
    box-shadow: 0 0 0 3px var(--danger-glow) !important;
}

.field-error {
    color: #f87171;
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    margin-bottom: 12px;
    display: none;
    letter-spacing: 0.03em;
}

.form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
.form-row .form-group { display: flex; flex-direction: column; }
.form-row .form-group input,
.form-row .form-group select { margin-bottom: 4px; }

.modal-buttons { display: flex; gap: 10px; margin-top: 16px; }

.btn-save {
    flex: 1; padding: 11px;
    background: var(--accent);
    color: white;
    border: none;
    border-radius: var(--radius-sm);
    cursor: pointer;
    font-family: 'Syne', sans-serif;
    font-size: 13px; font-weight: 700;
    transition: all 0.15s;
}
.btn-save:hover { background: var(--accent-dark); box-shadow: 0 4px 14px rgba(59,130,246,0.35); }
.btn-save:disabled { background: rgba(59,130,246,0.3); cursor: not-allowed; box-shadow: none; }

.btn-cancel {
    flex: 1; padding: 11px;
    background: rgba(255,255,255,0.05);
    color: var(--text-dim);
    border: 1px solid var(--border);
    border-radius: var(--radius-sm);
    cursor: pointer;
    font-family: 'Syne', sans-serif;
    font-size: 13px; font-weight: 700;
    transition: all 0.15s;
}
.btn-cancel:hover { background: rgba(255,255,255,0.08); color: var(--text); }

.btn-close-modal {
    position: absolute;
    top: 18px; right: 18px;
    background: rgba(255,255,255,0.06);
    border: 1px solid var(--border);
    border-radius: 6px;
    width: 28px; height: 28px;
    display: flex; align-items: center; justify-content: center;
    font-size: 14px;
    cursor: pointer;
    color: var(--text-muted);
    transition: all 0.15s;
}
.btn-close-modal:hover { background: rgba(255,255,255,0.10); color: var(--text); }

.modal-error {
    background: rgba(239,68,68,0.10);
    color: #f87171;
    border: 1px solid rgba(239,68,68,0.2);
    border-radius: var(--radius-sm);
    padding: 10px 14px;
    font-size: 12px;
    margin-bottom: 16px;
    display: none;
    font-family: 'DM Mono', monospace;
}

.modal-success {
    background: rgba(34,197,94,0.10);
    color: #4ade80;
    border: 1px solid rgba(34,197,94,0.2);
    border-radius: var(--radius-sm);
    padding: 10px 14px;
    font-size: 12px;
    margin-bottom: 16px;
    display: none;
    font-family: 'DM Mono', monospace;
}

.modal-spinner {
    display: none;
    position: absolute;
    inset: 0;
    background: rgba(8,12,20,0.7);
    border-radius: 14px;
    align-items: center;
    justify-content: center;
    font-size: 13px;
    color: var(--text-muted);
    font-family: 'DM Mono', monospace;
    z-index: 1;
    backdrop-filter: blur(4px);
}
.modal-spinner.active { display: flex; }

/* Select wrapper */
.select-wrapper { position: relative; margin-bottom: 4px; }
.select-wrapper::after {
    content: '▾';
    position: absolute;
    right: 12px; top: 50%;
    transform: translateY(-50%);
    pointer-events: none;
    color: var(--text-muted);
    font-size: 12px;
}
.select-wrapper select { padding-right: 30px; cursor: pointer; }
.select-wrapper select:disabled { opacity: 0.4; cursor: not-allowed; }

/* City autocomplete */
.address-wrapper { position: relative; margin-bottom: 4px; }
.address-wrapper input { margin-bottom: 0; }

.address-dropdown {
    position: absolute;
    top: calc(100% + 4px);
    left: 0; right: 0;
    background: var(--surface-2);
    border: 1px solid var(--border-2);
    border-radius: var(--radius-sm);
    box-shadow: 0 12px 40px rgba(0,0,0,0.4);
    z-index: 99999;
    max-height: 200px;
    overflow-y: auto;
    display: none;
}
.address-dropdown.open { display: block; }
.address-dropdown::-webkit-scrollbar { width: 3px; }
.address-dropdown::-webkit-scrollbar-thumb { background: var(--border-2); }

.address-option {
    padding: 9px 13px;
    cursor: pointer;
    font-size: 13px;
    color: var(--text-dim);
    border-bottom: 1px solid var(--border);
    transition: background 0.1s;
}
.address-option:last-child { border-bottom: none; }
.address-option:hover,
.address-option.highlighted { background: var(--accent-glow); color: var(--text); }
.address-option .addr-main { font-weight: 600; font-size: 13px; }
.address-no-results { padding: 14px; font-size: 12px; color: var(--text-muted); text-align: center; font-family: 'DM Mono', monospace; }

/* City badge */
.city-selected-badge {
    display: none;
    align-items: center;
    gap: 8px;
    background: var(--accent-glow);
    border: 1px solid rgba(59,130,246,0.25);
    border-radius: var(--radius-sm);
    padding: 8px 12px;
    margin-bottom: 4px;
}
.city-selected-badge .badge-icon { font-size: 13px; }
.city-selected-badge .badge-text { flex: 1; font-size: 12.5px; color: #93c5fd; font-weight: 600; }
.city-selected-badge .badge-clear { cursor: pointer; color: rgba(147,197,253,0.5); font-size: 15px; flex-shrink: 0; }
.city-selected-badge .badge-clear:hover { color: #93c5fd; }
</style>
</head>
<body>

<div id="toast-container"></div>

<div id="confirm-overlay">
    <div id="confirm-box">
        <div class="confirm-icon">🗑️</div>
        <h4 id="confirm-title">Delete Customer</h4>
        <p id="confirm-msg">Are you sure you want to delete this customer? This cannot be undone.</p>
        <div class="confirm-btns">
            <button class="btn-confirm-cancel" id="confirmNo">Cancel</button>
            <button class="btn-confirm-ok" id="confirmYes">Delete</button>
        </div>
    </div>
</div>

<div class="container">
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp"/>

    <div class="content">
        <div class="page-header">
            <div class="page-title-group">
                <div class="page-eyebrow">Management</div>
                <div class="page-title">Customers</div>
                <div class="page-subtitle" id="customerCountLabel">Loading records…</div>
            </div>
            <button class="btn-primary" id="openAddCustomer">+ Add Customer</button>
        </div>

        <div class="table-card">
            <table id="customersTable" class="display" style="width:100%">
                <thead><tr>
                    <th>#</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th></th>
                </tr></thead>
            </table>
        </div>
    </div>
</div>

<div class="action-menu" id="actionMenu">
    <div class="edit-option">✏️ Edit</div>
    <div class="delete-option">🗑️ Delete</div>
</div>

<!-- ADD MODAL -->
<div class="modal-overlay" id="addModal">
    <div class="modal-content">
        <button class="btn-close-modal" id="closeAddModal">✕</button>
        <h3>👤 Add Customer</h3>
        <div class="modal-error" id="addError"></div>
        <div class="modal-success" id="addSuccess"></div>

        <div class="form-row">
            <div class="form-group">
                <label>First Name</label>
                <input type="text" id="addFirstName" placeholder="John">
                <span class="field-error" id="errFirstName">Letters only, 2–50 chars</span>
            </div>
            <div class="form-group">
                <label>Last Name</label>
                <input type="text" id="addLastName" placeholder="Doe">
                <span class="field-error" id="errLastName">Letters only, 2–50 chars</span>
            </div>
        </div>

        <label>Email</label>
        <input type="text" id="addEmail" placeholder="john@example.com">
        <span class="field-error" id="errEmail">Enter a valid email address</span>

        <label>Phone Number</label>
        <input type="text" id="addPhone" placeholder="9876543210" maxlength="10">
        <span class="field-error" id="errPhone">Enter a valid 10-digit Indian mobile number</span>

        <label>State</label>
        <div class="select-wrapper">
            <select id="addState"><option value="">— Select State —</option></select>
        </div>
        <span class="field-error" id="errState">Please select a state</span>

        <label>City</label>
        <div class="city-selected-badge" id="addCityBadge">
            <span class="badge-icon">📍</span>
            <span class="badge-text" id="addCityBadgeText"></span>
            <span class="badge-clear" id="clearAddCity">✕</span>
        </div>
        <div class="address-wrapper" id="addCityWrapper">
            <input type="text" id="addCitySearch" placeholder="Select a state first…" autocomplete="off" disabled>
            <div class="address-dropdown" id="addCityDropdown"></div>
        </div>
        <input type="hidden" id="addCity">
        <span class="field-error" id="errCity">Please select a city</span>

        <div class="modal-buttons">
            <button class="btn-save" id="submitAdd">Add Customer</button>
            <button class="btn-cancel" id="cancelAdd">Cancel</button>
        </div>
    </div>
</div>

<!-- EDIT MODAL -->
<div class="modal-overlay" id="editModal">
    <div class="modal-content">
        <div class="modal-spinner" id="editSpinner">Loading…</div>
        <button class="btn-close-modal" id="closeEditModal">✕</button>
        <h3>✏️ Edit Customer</h3>
        <input type="hidden" id="editId">
        <div class="modal-error" id="editError"></div>

        <div class="form-row">
            <div class="form-group">
                <label>First Name</label>
                <input type="text" id="editFirstName">
                <span class="field-error" id="errEditFirstName">Letters only, 2–50 chars</span>
            </div>
            <div class="form-group">
                <label>Last Name</label>
                <input type="text" id="editLastName">
                <span class="field-error" id="errEditLastName">Letters only, 2–50 chars</span>
            </div>
        </div>

        <label>Email</label>
        <input type="text" id="editEmail">
        <span class="field-error" id="errEditEmail">Enter a valid email address</span>

        <label>Phone Number</label>
        <input type="text" id="editPhone" maxlength="10">
        <span class="field-error" id="errEditPhone">Enter a valid 10-digit Indian mobile number</span>

        <label>State</label>
        <div class="select-wrapper">
            <select id="editState"><option value="">— Select State —</option></select>
        </div>
        <span class="field-error" id="errEditState">Please select a state</span>

        <label>City</label>
        <div class="city-selected-badge" id="editCityBadge">
            <span class="badge-icon">📍</span>
            <span class="badge-text" id="editCityBadgeText"></span>
            <span class="badge-clear" id="clearEditCity">✕</span>
        </div>
        <div class="address-wrapper" id="editCityWrapper">
            <input type="text" id="editCitySearch" placeholder="Select a state first…" autocomplete="off" disabled>
            <div class="address-dropdown" id="editCityDropdown"></div>
        </div>
        <input type="hidden" id="editCity">
        <span class="field-error" id="errEditCity">Please select a city</span>

        <div class="modal-buttons">
            <button class="btn-save" id="saveEdit">Save Changes</button>
            <button class="btn-cancel" id="cancelEdit">Cancel</button>
        </div>
    </div>
</div>

<script>
const INDIA_DATA = {
  "Andhra Pradesh":["Vijayawada","Visakhapatnam","Tirupati","Guntur","Kakinada","Kurnool","Rajamahendravaram","Nellore","Anantapur","Kadapa","Srikakulam","Vizianagaram","Eluru","Ongole","Chittoor","Hindupur","Tenali","Proddatur","Nandyal","Adoni"],
  "Arunachal Pradesh":["Itanagar","Naharlagun","Pasighat","Tezpur","Bomdila","Ziro","Along","Tezu","Roing","Khonsa"],
  "Assam":["Guwahati","Silchar","Dibrugarh","Jorhat","Nagaon","Tinsukia","Tezpur","Bongaigaon","Dhubri","Diphu","Goalpara","Sivasagar","Golaghat","Karimganj","Hailakandi","North Lakhimpur"],
  "Bihar":["Patna","Gaya","Bhagalpur","Muzaffarpur","Purnia","Darbhanga","Bihar Sharif","Arrah","Begusarai","Katihar","Munger","Chhapra","Hajipur","Dehri","Siwan","Motihari","Nawada","Bagaha","Buxar","Kishanganj","Sitamarhi","Saharsa","Sasaram","Aurangabad"],
  "Chandigarh":["Chandigarh"],
  "Chhattisgarh":["Raipur","Bhilai","Bilaspur","Korba","Durg","Rajnandgaon","Jagdalpur","Ambikapur","Raigarh","Dhamtari","Mahasamund","Champa"],
  "Dadra and Nagar Haveli and Daman and Diu":["Daman","Diu","Silvassa"],
  "Delhi":["New Delhi","Delhi","Dwarka","Rohini","Janakpuri","Laxmi Nagar","Shahdara","Karol Bagh","Pitampura","Saket","Vasant Kunj","Mayur Vihar","Preet Vihar","Uttam Nagar","Najafgarh"],
  "Goa":["Panaji","Margao","Vasco da Gama","Mapusa","Ponda","Bicholim","Curchorem","Sanquelim","Valpoi","Pernem"],
  "Gujarat":["Ahmedabad","Surat","Vadodara","Rajkot","Bhavnagar","Jamnagar","Junagadh","Gandhinagar","Anand","Navsari","Morbi","Nadiad","Surendranagar","Bharuch","Mehsana","Bhuj","Porbandar","Palanpur","Valsad","Amreli","Botad","Dahod","Godhra","Himatnagar","Patan","Veraval","Gandhidham","Ankleshwar"],
  "Haryana":["Gurugram","Faridabad","Ambala","Hisar","Rohtak","Karnal","Panipat","Sonipat","Panchkula","Bhiwani","Sirsa","Bahadurgarh","Jind","Thanesar","Kaithal","Rewari","Palwal","Yamunanagar","Narnaul","Fatehabad"],
  "Himachal Pradesh":["Shimla","Dharamsala","Solan","Mandi","Palampur","Baddi","Nahan","Kullu","Hamirpur","Una","Chamba","Bilaspur","Kangra","Sundarnagar"],
  "Jammu and Kashmir":["Srinagar","Jammu","Anantnag","Baramulla","Sopore","Kathua","Udhampur","Punch","Rajouri","Leh","Kargil","Kupwara","Pulwama"],
  "Jharkhand":["Ranchi","Jamshedpur","Dhanbad","Bokaro","Deoghar","Phusro","Hazaribagh","Giridih","Ramgarh","Medininagar","Chirkunda","Chaibasa","Dumka","Jamtara","Pakur"],
  "Karnataka":["Bengaluru","Mysuru","Hubballi","Mangaluru","Belagavi","Kalaburagi","Ballari","Vijayapura","Shivamogga","Tumakuru","Udupi","Dharwad","Bidar","Hassan","Raichur","Davanagere","Chitradurga","Chikkamagaluru","Bagalkot","Mandya","Gadag","Yadgir","Hosapete","Ramanagara","Chikkaballapur","Kolar","Robertson Pet","Tiptur","Srinivaspur"],
  "Kerala":["Thiruvananthapuram","Kochi","Kozhikode","Kollam","Thrissur","Palakkad","Alappuzha","Kannur","Kottayam","Malappuram","Kasaragod","Idukki","Pathanamthitta","Wayanad","Punalur","Payyannur","Angamaly","Chalakudy","Tirur","Perinthalmanna","Irinjalakuda","Kayamkulam","Cherthala","Varkala","Vadakara"],
  "Ladakh":["Leh","Kargil"],
  "Lakshadweep":["Kavaratti"],
  "Madhya Pradesh":["Indore","Bhopal","Jabalpur","Gwalior","Ujjain","Sagar","Dewas","Satna","Ratlam","Rewa","Murwara","Singrauli","Burhanpur","Khandwa","Bhind","Chhindwara","Guna","Shivpuri","Vidisha","Chhatarpur","Damoh","Mandsaur","Khargone","Neemuch","Pithampur","Hoshangabad","Itarsi","Sehore","Betul","Seoni","Datia","Nagda"],
  "Maharashtra":["Mumbai","Pune","Nagpur","Nashik","Thane","Aurangabad","Solapur","Amravati","Kolhapur","Navi Mumbai","Sangli","Malegaon","Jalgaon","Akola","Latur","Dhule","Ahmednagar","Chandrapur","Parbhani","Ichalkaranji","Jalna","Ambarnath","Bhiwandi","Panvel","Nanded","Ulhasnagar","Nandurbar","Satara","Osmanabad","Wardha","Yavatmal","Hingoli","Buldhana","Washim","Gondia","Bhandara","Gadchiroli","Sindhudurg","Raigad","Ratnagiri","Alibaug"],
  "Manipur":["Imphal","Thoubal","Kakching","Ukhrul","Senapati","Chandel","Churachandpur","Bishnupur","Tamenglong"],
  "Meghalaya":["Shillong","Tura","Jowai","Nongstoin","Williamnagar","Resubelpara","Baghmara","Nongpoh"],
  "Mizoram":["Aizawl","Lunglei","Saiha","Champhai","Kolasib","Serchhip","Lawngtlai","Mamit"],
  "Nagaland":["Kohima","Dimapur","Mokokchung","Tuensang","Wokha","Zunheboto","Phek","Mon","Longleng","Peren","Kiphire"],
  "Odisha":["Bhubaneswar","Cuttack","Rourkela","Brahmapur","Sambalpur","Puri","Balasore","Bhadrak","Baripada","Jharsuguda","Bargarh","Paradip","Angul","Dhenkanal","Kendujhar","Jeypore","Rayagada","Phulbani","Bolangir","Koraput","Sundargarh","Boudh"],
  "Puducherry":["Puducherry","Karaikal","Mahe","Yanam"],
  "Punjab":["Ludhiana","Amritsar","Jalandhar","Patiala","Bathinda","Mohali","Hoshiarpur","Batala","Pathankot","Moga","Abohar","Malerkotla","Khanna","Phagwara","Muktsar","Barnala","Rajpura","Firozpur","Kapurthala","Ropar","Sangrur","Fatehgarh Sahib","Faridkot","Mansa"],
  "Rajasthan":["Jaipur","Jodhpur","Kota","Bikaner","Ajmer","Udaipur","Bhilwara","Alwar","Bharatpur","Sikar","Pali","Sri Ganganagar","Jhunjhunu","Kishangarh","Baran","Dhaulpur","Tonk","Beawar","Hanumangarh","Gangapur City","Sawai Madhopur","Nagaur","Jhalawar","Barmer","Churu","Bundi","Rajsamand","Dungarpur","Banswara","Chittorgarh","Sirohi","Jalore","Karauli","Pratapgarh"],
  "Sikkim":["Gangtok","Namchi","Jorethang","Mangan","Gyalshing","Rangpo"],
  "Tamil Nadu":["Chennai","Coimbatore","Madurai","Tiruchirappalli","Salem","Tirunelveli","Tiruppur","Vellore","Erode","Thoothukudi","Thanjavur","Dindigul","Kanchipuram","Nagercoil","Ambattur","Tiruvannamalai","Hosur","Karur","Kumbakonam","Cuddalore","Rajapalayam","Sivakasi","Pudukkottai","Nagapattinam","Pollachi","Namakkal","Krishnagiri","Virudhunagar","Ariyalur","Ranipet","Perambalur","Tirupattur","Tenkasi","Kallakurichi","Chengalpattu","Viluppuram","Villupuram"],
  "Telangana":["Hyderabad","Warangal","Nizamabad","Karimnagar","Khammam","Ramagundam","Mahbubnagar","Nalgonda","Adilabad","Suryapet","Miryalaguda","Siddipet","Bodhan","Jagtial","Mancherial","Nirmal","Kamareddy","Sangareddy","Medak","Vikarabad","Wanaparthy","Nagarkurnool","Bhongir","Tandur","Badangpet"],
  "Tripura":["Agartala","Dharmanagar","Udaipur","Kailashahar","Belonia","Khowai","Ambassa","Sonamura","Bishramganj"],
  "Uttar Pradesh":["Lucknow","Kanpur","Agra","Varanasi","Prayagraj","Ghaziabad","Noida","Meerut","Aligarh","Bareilly","Moradabad","Saharanpur","Gorakhpur","Faizabad","Jhansi","Mathura","Rampur","Shahjahanpur","Firozabad","Mau","Hapur","Etawah","Mirzapur","Bulandshahr","Sambhal","Amroha","Hardoi","Azamgarh","Bahraich","Sitapur","Muzaffarnagar","Lakhimpur","Jaunpur","Unnao","Rae Bareli","Orai","Banda","Fatehpur","Ballia","Sultanpur","Deoria","Basti","Gonda","Maharajganj","Kushinagar","Siddharth Nagar","Shrawasti","Balrampur","Etah","Mainpuri","Kasganj","Hathras","Auraiya","Badaun","Baghpat","Bijnor","Chandauli","Chitrakoot","Hamirpur","Jalaun","Kannauj","Kaushambi","Lalitpur","Mahoba","Pilibhit","Pratapgarh"],
  "Uttarakhand":["Dehradun","Haridwar","Roorkee","Haldwani","Rudrapur","Kashipur","Rishikesh","Nainital","Mussoorie","Pithoragarh","Almora","Kotdwar","Ramnagar","Srinagar","Bageshwar","Champawat","Uttarkashi","Tehri","Pauri","Chamoli"],
  "West Bengal":["Kolkata","Asansol","Siliguri","Durgapur","Bardhaman","Malda","Baharampur","Habra","Kharagpur","Shantipur","Dankuni","Dhulian","Ranaghat","Haldia","Raiganj","Krishnanagar","Nabadwip","Medinipur","Jalpaiguri","Balurghat","Basirhat","Bankura","Chakdaha","Darjeeling","Alipurduar","Cooch Behar","Purulia","Kalna","Suri","Bishnupur","Tamluk","Contai","Ghatal","Arambag","Bolpur"]
};

const STATES = Object.keys(INDIA_DATA).sort((a,b) => a.localeCompare(b));

function populateStates(selectEl) {
    selectEl.find('option:not(:first)').remove();
    STATES.forEach(s => selectEl.append($('<option>').val(s).text(s)));
}
function getCities(stateName) {
    return (INDIA_DATA[stateName]||[]).slice().sort((a,b)=>a.localeCompare(b));
}

function showToast(msg, type) {
    const icons = { success:'✅', error:'❌', info:'ℹ️' };
    const toast = $('<div class="toast '+type+'">'
        +'<span class="toast-icon">'+(icons[type]||'ℹ️')+'</span>'
        +'<span class="toast-msg">'+msg+'</span>'
        +'<button class="toast-close">✕</button>'
        +'</div>');
    $('#toast-container').append(toast);
    requestAnimationFrame(() => requestAnimationFrame(() => toast.addClass('show')));
    const timer = setTimeout(() => dismissToast(toast), 3500);
    toast.find('.toast-close').on('click', function(){ clearTimeout(timer); dismissToast(toast); });
}
function dismissToast(toast) {
    toast.removeClass('show').addClass('hide');
    setTimeout(() => toast.remove(), 350);
}

function initCityAutocomplete(cfg) {
    const { searchInput, dropdown, hiddenInput, badge, badgeText, clearBtn, fieldErr, wrapper } = cfg;
    let cityList = [], hlIndex = -1;

    function loadState(stateName) {
        reset();
        cityList = getCities(stateName);
        searchInput.prop('disabled', !cityList.length)
                   .attr('placeholder', cityList.length ? 'Type city name…' : 'No cities for this state');
    }
    function getMatches(q) {
        const lower = q.toLowerCase();
        const starts = cityList.filter(c => c.toLowerCase().startsWith(lower));
        const rest   = cityList.filter(c => !c.toLowerCase().startsWith(lower) && c.toLowerCase().includes(lower));
        return [...starts, ...rest].slice(0,10);
    }
    function hl(text, q) {
        if (!q) return text;
        const i = text.toLowerCase().indexOf(q.toLowerCase());
        if (i < 0) return text;
        return text.slice(0,i)+'<strong style="color:#60a5fa">'+text.slice(i,i+q.length)+'</strong>'+text.slice(i+q.length);
    }
    function render(matches, q) {
        dropdown.empty(); hlIndex = -1;
        if (!matches.length) { dropdown.html('<div class="address-no-results">No cities found</div>'); }
        else { matches.forEach(c => $('<div class="address-option">').html('<div class="addr-main">'+hl(c,q)+'</div>').on('mousedown', e => { e.preventDefault(); pick(c); }).appendTo(dropdown)); }
        dropdown.addClass('open');
    }
    function pick(cityName) {
        hiddenInput.val(cityName); searchInput.val('');
        dropdown.removeClass('open').empty();
        badgeText.text(cityName); badge.css('display','flex');
        wrapper.hide(); fieldErr.hide();
    }
    function preselect(cityName) {
        if (!cityName) return;
        hiddenInput.val(cityName); badgeText.text(cityName);
        badge.css('display','flex'); wrapper.hide();
    }
    clearBtn.on('click', () => { hiddenInput.val(''); badge.hide(); wrapper.show(); searchInput.val('').focus(); });
    searchInput.on('input', function() { const q=$(this).val().trim(); if(!q){dropdown.removeClass('open');return;} render(getMatches(q),q); });
    searchInput.on('keydown', function(e) {
        const items = dropdown.find('.address-option'); if(!items.length) return;
        if (e.key==='ArrowDown') { e.preventDefault(); hlIndex=Math.min(hlIndex+1,items.length-1); items.removeClass('highlighted').eq(hlIndex).addClass('highlighted'); }
        else if (e.key==='ArrowUp') { e.preventDefault(); hlIndex=Math.max(hlIndex-1,0); items.removeClass('highlighted').eq(hlIndex).addClass('highlighted'); }
        else if (e.key==='Enter'&&hlIndex>=0) { e.preventDefault(); items.eq(hlIndex).trigger('mousedown'); }
        else if (e.key==='Escape') { dropdown.removeClass('open'); }
    });
    searchInput.on('blur', () => setTimeout(() => dropdown.removeClass('open'), 160));
    function reset() {
        hiddenInput.val(''); searchInput.val('').prop('disabled',true).attr('placeholder','Select a state first…');
        dropdown.removeClass('open').empty(); badge.hide(); wrapper.show();
        fieldErr.hide(); cityList=[]; hlIndex=-1;
    }
    return { loadState, preselect, reset };
}

const RE_NAME  = /^[a-zA-Z\s'\-]{2,50}$/;
const RE_EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
const RE_PHONE = /^[6-9]\d{9}$/;

function setErr(inputSel, errSel, show) {
    if (show) { $(inputSel).addClass('input-error'); $(errSel).show(); }
    else      { $(inputSel).removeClass('input-error'); $(errSel).hide(); }
}
function clearEditErrors() {
    $('#editError').hide().text('');
    ['#editFirstName','#editLastName','#editEmail','#editPhone','#editState'].forEach(s => $(s).removeClass('input-error'));
    ['#errEditFirstName','#errEditLastName','#errEditEmail','#errEditPhone','#errEditState','#errEditCity'].forEach(s => $(s).hide());
}

$(document).ready(function(){
    let activeRowData = null, pendingDeleteId = null, pendingDeleteName = '';

    populateStates($('#addState'));
    populateStates($('#editState'));

    const addCityAC = initCityAutocomplete({
        searchInput:$('#addCitySearch'), dropdown:$('#addCityDropdown'),
        hiddenInput:$('#addCity'), badge:$('#addCityBadge'),
        badgeText:$('#addCityBadgeText'), clearBtn:$('#clearAddCity'),
        fieldErr:$('#errCity'), wrapper:$('#addCityWrapper')
    });
    const editCityAC = initCityAutocomplete({
        searchInput:$('#editCitySearch'), dropdown:$('#editCityDropdown'),
        hiddenInput:$('#editCity'), badge:$('#editCityBadge'),
        badgeText:$('#editCityBadgeText'), clearBtn:$('#clearEditCity'),
        fieldErr:$('#errEditCity'), wrapper:$('#editCityWrapper')
    });

    $('#addState').on('change', function() {
        setErr('#addState','#errState',false);
        const s=$(this).val(); if(s) addCityAC.loadState(s); else addCityAC.reset();
    });
    $('#editState').on('change', function() {
        setErr('#editState','#errEditState',false);
        const s=$(this).val(); if(s) editCityAC.loadState(s); else editCityAC.reset();
    });

    const table = $('#customersTable').DataTable({
        serverSide: true, processing: true,
        ajax: {
            url: '/api/show-customers', type: 'POST',
            data: function(d) {
                return { draw:d.draw, start:d.start, length:d.length, search:d.search.value };
            },
            error: (xhr) => console.error('DataTable error:', xhr.status, xhr.responseText)
        },
        columns: [
            { data:null, orderable:false, render:(d,t,r,meta) => '<span style="font-family:\'DM Mono\',monospace;font-size:11px;color:var(--text-muted)">'+(meta.settings._iDisplayStart+meta.row+1)+'</span>' },
            { data:'fullName', render:(d) => '<span style="font-weight:700;color:var(--text)">'+(d||'—')+'</span>' },
            { data:'email',    render:(d) => '<span style="font-family:\'DM Mono\',monospace;font-size:11.5px">'+(d||'—')+'</span>' },
            { data:'phoneNumber', render:(d) => '<span style="font-family:\'DM Mono\',monospace;font-size:12px">'+(d||'—')+'</span>' },
            { data:'address', orderable:false, createdCell:(td)=>$(td).addClass('address-cell'),
              render:(data) => { const a=data||'—'; return '<span title="'+$('<div>').text(a).html()+'">'+$('<div>').text(a).html()+'</span>'; } },
            { data:null, orderable:false, render:() => '<span class="edit-icon">⋯</span>' }
        ],
        dom: 'lfrtip',
        drawCallback: function(settings) {
            const total = settings.fnRecordsTotal();
            $('#customerCountLabel').text(total + ' total record' + (total !== 1 ? 's' : ''));
        }
    });

    $(document).on('click', '.edit-icon', function(e){
        e.stopPropagation();
        activeRowData = table.row($(this).closest('tr')).data();
        if (!activeRowData) return;
        const off = $(this).offset();
        $('#actionMenu').css({ top:(off.top+$(this).outerHeight()+4)+'px', left:(off.left-100)+'px' }).show();
    });
    $(document).on('click', () => $('#actionMenu').hide());

    // ── ADD ──
    $('#openAddCustomer').on('click', () => { resetAddModal(); $('#addModal').addClass('active'); });
    function closeAddModal(){ $('#addModal').removeClass('active'); resetAddModal(); }
    function resetAddModal(){
        $('#addFirstName,#addLastName,#addEmail,#addPhone').val('').removeClass('input-error');
        $('#addState').val('').removeClass('input-error');
        $('#errFirstName,#errLastName,#errEmail,#errPhone,#errState,#errCity').hide();
        $('#addError').hide().text(''); $('#addSuccess').hide().text('');
        $('#submitAdd').prop('disabled',false).text('Add Customer');
        addCityAC.reset();
    }
    $('#addFirstName').on('blur', function(){ const v=$(this).val().trim(); if(v) setErr('#addFirstName','#errFirstName',!RE_NAME.test(v)); });
    $('#addLastName').on('blur',  function(){ const v=$(this).val().trim(); if(v) setErr('#addLastName','#errLastName',!RE_NAME.test(v)); });
    $('#addEmail').on('blur',     function(){ const v=$(this).val().trim(); if(v) setErr('#addEmail','#errEmail',!RE_EMAIL.test(v)); });
    $('#addPhone').on('input',    function(){ $(this).val($(this).val().replace(/\D/g,'')); });
    $('#addPhone').on('blur',     function(){ const v=$(this).val().trim(); if(v) setErr('#addPhone','#errPhone',!RE_PHONE.test(v)); });
    $('#closeAddModal,#cancelAdd').on('click', closeAddModal);
    $('#addModal').on('click', function(e){ if($(e.target).is('#addModal')) closeAddModal(); });

    $('#submitAdd').on('click', function(){
        $('#addError').hide();
        const fn=($('#addFirstName').val()||'').trim(), ln=($('#addLastName').val()||'').trim();
        const em=($('#addEmail').val()||'').trim(), ph=($('#addPhone').val()||'').trim();
        const state=$('#addState').val(), city=($('#addCity').val()||'').trim();
        const addr=(city&&state)?city+', '+state:'';
        let ok=true;
        if(!fn||!RE_NAME.test(fn))  { setErr('#addFirstName','#errFirstName',true); ok=false; }
        if(!ln||!RE_NAME.test(ln))  { setErr('#addLastName','#errLastName',true); ok=false; }
        if(!em||!RE_EMAIL.test(em)) { setErr('#addEmail','#errEmail',true); ok=false; }
        if(!ph||!RE_PHONE.test(ph)) { setErr('#addPhone','#errPhone',true); ok=false; }
        if(!state)                  { setErr('#addState','#errState',true); ok=false; }
        if(!city)                   { $('#errCity').show(); ok=false; }
        if(!ok) return;
        $('#submitAdd').prop('disabled',true).text('Saving…');
        $.ajax({
            url:'/api/customer-save', type:'POST', contentType:'application/json',
            data: JSON.stringify({firstName:fn,lastName:ln,email:em,phoneNumber:ph,address:addr}),
            success:(res) => { table.ajax.reload(null,false); closeAddModal(); showToast(res.message||'Customer added successfully!','success'); },
            error:(xhr) => {
                let msg='Failed to add customer.';
                try { const e=JSON.parse(xhr.responseText); msg=e.errors?Object.values(e.errors).join(' '):e.message||e.error||msg; } catch(_){}
                $('#addError').text(msg).show();
                $('#submitAdd').prop('disabled',false).text('Add Customer');
            }
        });
    });

    // ── EDIT ──
    $(document).on('click', '.edit-option', function(e){
        e.stopPropagation(); $('#actionMenu').hide();
        if (!activeRowData){ showToast('No row selected','error'); return; }
        clearEditErrors(); editCityAC.reset();
        $('#editId').val(activeRowData.id);
        $('#editFirstName').val(activeRowData.firstName||'');
        $('#editLastName').val(activeRowData.lastName||'');
        $('#editEmail').val(activeRowData.email||'');
        $('#editPhone').val(activeRowData.phoneNumber||'');
        const addr=activeRowData.address||'';
        if (addr.includes(',')) {
            const city=addr.split(',')[0].trim();
            const state=addr.split(',').slice(1).join(',').trim();
            if (state && INDIA_DATA[state]) {
                $('#editState').val(state);
                editCityAC.loadState(state);
                editCityAC.preselect(city);
            }
        }
        $('#editModal').addClass('active');
    });

    function closeEditModal(){
        $('#editModal').removeClass('active'); $('#editSpinner').removeClass('active');
        clearEditErrors(); editCityAC.reset(); $('#editState').val('');
    }
    $('#closeEditModal,#cancelEdit').on('click', closeEditModal);
    $('#editModal').on('click', function(e){ if($(e.target).is('#editModal')) closeEditModal(); });
    $('#editPhone').on('input', function(){ $(this).val($(this).val().replace(/\D/g,'')); });
    $('#editFirstName').on('blur', function(){ const v=$(this).val().trim(); if(v) setErr('#editFirstName','#errEditFirstName',!RE_NAME.test(v)); });
    $('#editLastName').on('blur',  function(){ const v=$(this).val().trim(); if(v) setErr('#editLastName','#errEditLastName',!RE_NAME.test(v)); });
    $('#editEmail').on('blur',     function(){ const v=$(this).val().trim(); if(v) setErr('#editEmail','#errEditEmail',!RE_EMAIL.test(v)); });
    $('#editPhone').on('blur',     function(){ const v=$(this).val().trim(); if(v) setErr('#editPhone','#errEditPhone',!RE_PHONE.test(v)); });

    $('#saveEdit').on('click', function(){
        clearEditErrors();
        const id=$('#editId').val();
        const fn=($('#editFirstName').val()||'').trim(), ln=($('#editLastName').val()||'').trim();
        const em=($('#editEmail').val()||'').trim(), ph=($('#editPhone').val()||'').trim();
        const state=$('#editState').val(), city=($('#editCity').val()||'').trim();
        const addr=(city&&state)?city+', '+state:'';
        let ok=true;
        if(!fn||!RE_NAME.test(fn))  { setErr('#editFirstName','#errEditFirstName',true); ok=false; }
        if(!ln||!RE_NAME.test(ln))  { setErr('#editLastName','#errEditLastName',true); ok=false; }
        if(!em||!RE_EMAIL.test(em)) { setErr('#editEmail','#errEditEmail',true); ok=false; }
        if(ph&&!RE_PHONE.test(ph))  { setErr('#editPhone','#errEditPhone',true); ok=false; }
        if(!state)                  { setErr('#editState','#errEditState',true); ok=false; }
        if(!city)                   { $('#errEditCity').show(); ok=false; }
        if(!ok) return;
        $.ajax({
            url:'/api/customer-update/'+id, type:'PUT', contentType:'application/json',
            data: JSON.stringify({firstName:fn,lastName:ln,email:em,phoneNumber:ph,address:addr}),
            success:(res) => { closeEditModal(); table.ajax.reload(null,false); showToast(res.message||'Customer updated successfully!','success'); },
            error:(xhr) => {
                let msg='Update failed.';
                try { const e=JSON.parse(xhr.responseText); msg=e.errors?Object.values(e.errors).join(' '):e.message||e.error||msg; } catch(_){}
                $('#editError').text(msg).show();
            }
        });
    });

    // ── DELETE ──
    $(document).on('click', '.delete-option', function(e){
        e.stopPropagation(); $('#actionMenu').hide();
        if (!activeRowData){ showToast('No row selected','error'); return; }
        pendingDeleteId=parseInt(activeRowData.id);
        pendingDeleteName=((activeRowData.firstName||'')+' '+(activeRowData.lastName||'')).trim();
        if (isNaN(pendingDeleteId)){ showToast('Could not resolve customer ID','error'); return; }
        $('#confirm-msg').text('Are you sure you want to delete "'+pendingDeleteName+'"? This cannot be undone.');
        $('#confirm-overlay').addClass('active');
    });

    $('#confirmNo').on('click', () => { $('#confirm-overlay').removeClass('active'); pendingDeleteId=null; });
    $('#confirm-overlay').on('click', function(e){ if($(e.target).is('#confirm-overlay')){ $('#confirm-overlay').removeClass('active'); pendingDeleteId=null; } });

    $('#confirmYes').on('click', function(){
        $('#confirm-overlay').removeClass('active');
        if (!pendingDeleteId) return;
        const id=pendingDeleteId; pendingDeleteId=null;
        $.ajax({
            url:'/api/customer-delete/'+id, type:'DELETE',
            success:(res) => { activeRowData=null; table.ajax.reload(null,false); showToast(res.message||'Customer deleted!','success'); },
            error:(xhr) => { console.error('Delete failed:',xhr.responseText); showToast('Delete failed — please try again.','error'); }
        });
    });
});
</script>
</body>
</html>
