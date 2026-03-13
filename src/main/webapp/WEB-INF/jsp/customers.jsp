<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customers — SalesPanel</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<style>
:root {
  --bg:#f0f4fa; --surface:#ffffff; --surface-2:#f8faff;
  --border:rgba(99,115,155,0.12); --border-2:rgba(99,115,155,0.18);
  --blue:#2563eb; --blue-soft:#eff4ff; --blue-glow:rgba(37,99,235,0.15);
  --indigo:#4f46e5; --teal:#0d9488; --teal-soft:#f0fdfb;
  --orange:#ea580c; --orange-soft:#fff7ed;
  --green:#16a34a; --green-soft:#f0fdf4;
  --red:#dc2626; --red-soft:#fff1f1;
  --text:#0f172a; --text-2:#334155; --text-3:#64748b; --text-4:#94a3b8;
  --radius:14px; --radius-sm:8px;
  --shadow:0 1px 3px rgba(15,23,42,0.06),0 4px 16px rgba(15,23,42,0.06);
  --shadow-md:0 4px 24px rgba(15,23,42,0.10);
  --shadow-lg:0 8px 40px rgba(15,23,42,0.14);
}
/* Re-declare under .main so sidebar CSS vars cannot override ours */
.main {
  --bg:#f0f4fa; --surface:#ffffff; --surface-2:#f8faff;
  --border:rgba(99,115,155,0.12); --border-2:rgba(99,115,155,0.18);
  --blue:#2563eb; --blue-soft:#eff4ff; --blue-glow:rgba(37,99,235,0.15);
  --indigo:#4f46e5; --teal:#0d9488; --teal-soft:#f0fdfb;
  --orange:#ea580c; --orange-soft:#fff7ed;
  --green:#16a34a; --green-soft:#f0fdf4;
  --red:#dc2626; --red-soft:#fff1f1;
  --text:#0f172a !important; --text-2:#334155; --text-3:#64748b; --text-4:#94a3b8;
  --radius:14px; --radius-sm:8px;
  --shadow:0 1px 3px rgba(15,23,42,0.06),0 4px 16px rgba(15,23,42,0.06);
  --shadow-md:0 4px 24px rgba(15,23,42,0.10);
  --shadow-lg:0 8px 40px rgba(15,23,42,0.14);
}
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);min-height:100vh;overflow-x:hidden;}

/* ── APP SHELL: sidebar + main sit side by side ── */
.app-layout{display:flex;min-height:100vh;}
.main{flex:1;min-width:0;display:flex;flex-direction:column;background:var(--bg);}
.content{padding:28px 32px;flex:1;}

/* PAGE HEADER */
.page-header{display:flex;align-items:flex-end;justify-content:space-between;margin-bottom:24px;}
.breadcrumb{display:flex;align-items:center;gap:6px;font-size:12px;color:#94a3b8;margin-bottom:4px;}
.breadcrumb span{color:#64748b;}
.page-title{font-size:26px;font-weight:800;color:#0f172a;letter-spacing:-0.04em;line-height:1;}
.btn-primary{display:inline-flex;align-items:center;gap:7px;padding:10px 22px;background:linear-gradient(135deg,var(--blue),var(--indigo));color:white;border:none;border-radius:10px;cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-weight:700;font-size:13.5px;transition:all 0.18s;box-shadow:0 4px 14px var(--blue-glow);}
.btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(37,99,235,0.3);}

/* STAT CARDS */
.stats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px;}
.stat-card{background:var(--surface);border-radius:var(--radius);padding:20px;box-shadow:var(--shadow);border:1px solid var(--border);position:relative;overflow:hidden;transition:transform 0.2s,box-shadow 0.2s;}
.stat-card:hover{transform:translateY(-2px);box-shadow:var(--shadow-md);}
.stat-card::before{content:'';position:absolute;top:0;right:0;width:100px;height:100px;border-radius:50%;opacity:0.06;}
.stat-card.blue::before{background:var(--blue);transform:translate(20px,-30px);}
.stat-card.teal::before{background:var(--teal);transform:translate(20px,-30px);}
.stat-card.orange::before{background:var(--orange);transform:translate(20px,-30px);}
.stat-card.green::before{background:var(--green);transform:translate(20px,-30px);}
.stat-icon-wrap{width:40px;height:40px;border-radius:11px;display:flex;align-items:center;justify-content:center;font-size:18px;margin-bottom:14px;}
.blue .stat-icon-wrap{background:var(--blue-soft);}
.teal .stat-icon-wrap{background:var(--teal-soft);}
.orange .stat-icon-wrap{background:var(--orange-soft);}
.green .stat-icon-wrap{background:var(--green-soft);}
.stat-label{font-size:11px;font-weight:600;color:#64748b;letter-spacing:0.04em;text-transform:uppercase;margin-bottom:6px;}
.stat-value{font-size:28px;font-weight:800;color:#0f172a;letter-spacing:-0.05em;line-height:1;}
.stat-sub{font-size:11.5px;color:#94a3b8;margin-top:6px;}
.stat-up{color:#16a34a;font-weight:700;}

/* TABLE CARD */
.table-card{background:var(--surface);border-radius:var(--radius);box-shadow:var(--shadow);border:1px solid var(--border);overflow:visible;}
.table-card>.table-toolbar{border-radius:var(--radius) var(--radius) 0 0;}
.table-card .dataTables_wrapper{border-radius:0 0 var(--radius) var(--radius);overflow:hidden;}
.table-toolbar{display:flex;align-items:center;justify-content:space-between;padding:16px 20px;border-bottom:1px solid var(--border);background:var(--surface);}
.table-toolbar-left{display:flex;align-items:center;gap:10px;}
.table-toolbar-title{font-size:14px;font-weight:700;color:#0f172a;}
.table-count-pill{background:var(--blue-soft);color:var(--blue);font-size:11px;font-weight:700;padding:2px 10px;border-radius:999px;font-family:'JetBrains Mono',monospace;}
.table-search{position:relative;}
.table-search input{padding:8px 14px 8px 36px;border-radius:9px;border:1.5px solid var(--border-2);background:var(--surface-2);font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;color:var(--text);outline:none;width:220px;transition:all 0.18s;}
.table-search input:focus{border-color:var(--blue);box-shadow:0 0 0 3px var(--blue-glow);}
.table-search input::placeholder{color:var(--text-4);}
.table-search-icon{position:absolute;left:11px;top:50%;transform:translateY(-50%);font-size:13px;color:var(--text-4);}

/* DATATABLES — hide built-in length+search, use our toolbar instead */
.dataTables_wrapper{padding:0;color:var(--text);}
.dataTables_wrapper .dataTables_length,
.dataTables_wrapper .dataTables_filter{display:none !important;}
table.dataTable{border-collapse:collapse !important;width:100% !important;margin:0 !important;}
table.dataTable thead th{background:#f8faff;color:#64748b;font-family:'Plus Jakarta Sans',sans-serif;font-size:11px;letter-spacing:0.06em;text-transform:uppercase;font-weight:700;padding:12px 18px;border-bottom:1px solid rgba(99,115,155,0.12);border-top:none;white-space:nowrap;}
table.dataTable thead th.sorting,table.dataTable thead th.sorting_asc,table.dataTable thead th.sorting_desc{background:#f8faff;}
table.dataTable tbody tr{background:#ffffff;transition:background 0.12s;}
table.dataTable tbody tr:hover{background:#f5f8ff;}
table.dataTable tbody td{padding:14px 18px;border-bottom:1px solid rgba(99,115,155,0.12);font-size:13.5px;color:#334155;vertical-align:middle;}
table.dataTable tbody tr:last-child td{border-bottom:none;}
table.dataTable tbody td.address-cell{max-width:200px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:12.5px;color:#64748b;}
div.dataTables_wrapper div.dataTables_info{font-family:'JetBrains Mono',monospace;font-size:11px;color:var(--text-4);border-top:1px solid var(--border);padding:14px 20px;background:var(--surface-2);}
div.dataTables_wrapper div.dataTables_paginate{border-top:1px solid var(--border);padding:14px 20px;background:var(--surface-2);text-align:right;}
div.dataTables_wrapper div.dataTables_paginate .paginate_button{font-family:'JetBrains Mono',monospace;font-size:11.5px;color:var(--text-3) !important;border-radius:8px !important;border:1px solid transparent !important;padding:6px 12px !important;transition:all 0.15s !important;}
div.dataTables_wrapper div.dataTables_paginate .paginate_button:hover{background:var(--blue-soft) !important;color:var(--blue) !important;border-color:rgba(37,99,235,0.2) !important;}
div.dataTables_wrapper div.dataTables_paginate .paginate_button.current,
div.dataTables_wrapper div.dataTables_paginate .paginate_button.current:hover{background:linear-gradient(135deg,var(--blue),var(--indigo)) !important;border-color:var(--blue) !important;color:white !important;box-shadow:0 4px 12px var(--blue-glow) !important;}
div.dataTables_wrapper div.dataTables_paginate .paginate_button.disabled,
div.dataTables_wrapper div.dataTables_paginate .paginate_button.disabled:hover{color:var(--text-4) !important;}

/* AVATARS */
.customer-avatar{width:34px;height:34px;border-radius:10px;display:inline-flex;align-items:center;justify-content:center;font-size:13px;font-weight:700;color:white;flex-shrink:0;margin-right:10px;}
.name-cell{display:flex;align-items:center;}
.av-0{background:linear-gradient(135deg,#3b82f6,#6366f1);}
.av-1{background:linear-gradient(135deg,#0d9488,#059669);}
.av-2{background:linear-gradient(135deg,#ea580c,#d97706);}
.av-3{background:linear-gradient(135deg,#7c3aed,#db2777);}
.av-4{background:linear-gradient(135deg,#0ea5e9,#3b82f6);}
.av-5{background:linear-gradient(135deg,#16a34a,#0d9488);}
.mono{font-family:'JetBrains Mono',monospace;font-size:12px;color:var(--text-3);}

/* ACTION BUTTON + MENU */
.edit-icon{cursor:pointer;display:inline-flex;align-items:center;justify-content:center;width:32px;height:32px;border-radius:8px;background:var(--surface-2);border:1px solid var(--border);font-size:16px;transition:all 0.15s;color:var(--text-3);}
.edit-icon:hover{background:var(--blue-soft);border-color:rgba(37,99,235,0.25);color:var(--blue);}
.action-menu{position:fixed;background:white;border:1px solid var(--border-2);border-radius:12px;display:none;z-index:9999;min-width:160px;box-shadow:var(--shadow-lg);overflow:hidden;padding:6px;}
.action-menu div{padding:9px 12px;cursor:pointer;color:var(--text-2);font-size:13px;font-weight:600;display:flex;align-items:center;gap:9px;transition:background 0.12s;border-radius:8px;}
.action-menu div:hover{background:var(--surface-2);}
.action-menu .delete-option{color:var(--red);}
.action-menu .delete-option:hover{background:var(--red-soft);}

/* TOAST */
#toast-container{position:fixed;top:20px;right:20px;z-index:99999;display:flex;flex-direction:column;gap:10px;pointer-events:none;}
.toast{display:flex;align-items:center;gap:12px;min-width:290px;max-width:380px;padding:14px 16px;border-radius:12px;font-size:13px;font-weight:600;color:white;box-shadow:var(--shadow-lg);pointer-events:all;opacity:0;transform:translateX(50px);transition:all 0.3s cubic-bezier(0.4,0,0.2,1);}
.toast.show{opacity:1;transform:translateX(0);}
.toast.hide{opacity:0;transform:translateX(50px);}
.toast.success{background:linear-gradient(135deg,#16a34a,#15803d);}
.toast.error{background:linear-gradient(135deg,#dc2626,#b91c1c);}
.toast.info{background:linear-gradient(135deg,var(--blue),var(--indigo));}
.toast-icon{font-size:16px;flex-shrink:0;}
.toast-msg{flex:1;line-height:1.4;}
.toast-close{cursor:pointer;opacity:0.7;font-size:15px;flex-shrink:0;background:none;border:none;color:white;padding:0;}

/* CONFIRM DIALOG */
#confirm-overlay{display:none;position:fixed;inset:0;background:rgba(15,23,42,0.5);z-index:20000;align-items:center;justify-content:center;backdrop-filter:blur(6px);}
#confirm-overlay.active{display:flex;}
#confirm-box{background:#ffffff !important;border-radius:18px;padding:32px;width:380px;max-width:94vw;box-shadow:0 32px 80px rgba(15,23,42,0.2);text-align:center;animation:popIn 0.25s cubic-bezier(0.34,1.56,0.64,1);}
@keyframes popIn{from{transform:scale(0.88);opacity:0;}to{transform:scale(1);opacity:1;}}
.confirm-icon-wrap{width:60px;height:60px;border-radius:16px;background:#fff1f1;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 16px;}
#confirm-box h4{font-size:18px;font-weight:800;color:#0f172a !important;margin-bottom:8px;}
#confirm-box p{font-size:13px;color:#64748b !important;line-height:1.6;margin-bottom:24px;}
.confirm-btns{display:flex;gap:10px;}
.btn-confirm-cancel{flex:1;padding:12px;background:#f1f5f9 !important;color:#334155 !important;border:1.5px solid #cbd5e1 !important;border-radius:10px;cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13.5px;font-weight:700;}
.btn-confirm-cancel:hover{background:#e2e8f0 !important;}
.btn-confirm-ok{flex:1;padding:12px;background:#dc2626;color:white;border:none;border-radius:10px;cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13.5px;font-weight:700;}
.btn-confirm-ok:hover{background:#b91c1c;}

/* MODALS */
.modal-overlay{display:none;position:fixed;inset:0;background:rgba(15,23,42,0.5);z-index:10000;align-items:center;justify-content:center;backdrop-filter:blur(6px);}
.modal-overlay.active{display:flex;}
.modal-content{background:#ffffff !important;color:#0f172a !important;border-radius:18px;padding:30px;width:500px;max-width:95vw;position:relative;max-height:90vh;overflow-y:auto;animation:popIn 0.25s cubic-bezier(0.34,1.56,0.64,1);box-shadow:0 32px 80px rgba(15,23,42,0.2);}
.modal-content::-webkit-scrollbar{width:4px;}
.modal-content::-webkit-scrollbar-thumb{background:var(--border-2);border-radius:2px;}
.modal-header{display:flex;align-items:center;gap:14px;margin-bottom:24px;padding-bottom:18px;border-bottom:1px solid var(--border);}
.modal-header-icon{width:44px;height:44px;border-radius:12px;background:var(--blue-soft);display:flex;align-items:center;justify-content:center;font-size:20px;}
.modal-header h3{font-size:18px;font-weight:800;color:var(--text);}
.modal-header p{font-size:12px;color:var(--text-4);margin-top:1px;}
.modal-content label{display:block;font-size:11.5px;font-weight:700;color:#64748b !important;margin-bottom:6px;letter-spacing:0.02em;}
.modal-content input,.modal-content select{width:100%;padding:10px 14px;margin-bottom:4px;border-radius:9px;border:1.5px solid #cbd5e1 !important;font-size:13.5px;color:#0f172a !important;background:#f8faff !important;font-family:'Plus Jakarta Sans',sans-serif;transition:all 0.15s;appearance:none;outline:none;}
.modal-content input::placeholder{color:#94a3b8 !important;}
.modal-content input:focus,.modal-content select:focus{border-color:#2563eb !important;background:white !important;box-shadow:0 0 0 4px rgba(37,99,235,0.15) !important;}
.modal-content input.input-error,.modal-content select.input-error{border-color:var(--red) !important;box-shadow:0 0 0 3px rgba(220,38,38,0.1) !important;}
.field-error{color:var(--red);font-size:10.5px;font-weight:600;margin-bottom:12px;display:none;}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:14px;}
.form-row .form-group{display:flex;flex-direction:column;}
.modal-buttons{display:flex;gap:10px;margin-top:20px;}
.btn-save{flex:1;padding:12px;background:linear-gradient(135deg,var(--blue),var(--indigo));color:white;border:none;border-radius:10px;cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:14px;font-weight:700;transition:all 0.15s;box-shadow:0 4px 14px var(--blue-glow);}
.btn-save:hover{transform:translateY(-1px);box-shadow:0 8px 24px rgba(37,99,235,0.3);}
.btn-save:disabled{background:#c7d2fe;cursor:not-allowed;box-shadow:none;transform:none;}
.btn-cancel{flex:1;padding:12px;background:#f1f5f9 !important;color:#334155 !important;border:1.5px solid #cbd5e1 !important;border-radius:10px;cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:14px;font-weight:700;}
.btn-cancel:hover{background:#e2e8f0 !important;}
.btn-close-modal{position:absolute;top:20px;right:20px;background:var(--surface-2);border:1px solid var(--border);border-radius:8px;width:30px;height:30px;display:flex;align-items:center;justify-content:center;font-size:14px;cursor:pointer;color:var(--text-3);transition:all 0.15s;}
.btn-close-modal:hover{background:var(--bg);color:var(--text);}
.modal-error{background:var(--red-soft);color:var(--red);border:1.5px solid rgba(220,38,38,0.2);border-radius:9px;padding:10px 14px;font-size:12.5px;margin-bottom:16px;display:none;font-weight:600;}
.modal-success{background:var(--green-soft);color:var(--green);border:1.5px solid rgba(22,163,74,0.2);border-radius:9px;padding:10px 14px;font-size:12.5px;margin-bottom:16px;display:none;font-weight:600;}
.modal-spinner{display:none;position:absolute;inset:0;background:rgba(255,255,255,0.85);border-radius:18px;align-items:center;justify-content:center;font-size:13px;color:var(--text-4);z-index:1;backdrop-filter:blur(4px);}
.modal-spinner.active{display:flex;}

/* SELECT WRAPPER */
.select-wrapper{position:relative;margin-bottom:4px;}
.select-wrapper::after{content:'▾';position:absolute;right:13px;top:50%;transform:translateY(-50%);pointer-events:none;color:var(--text-3);font-size:12px;}
.select-wrapper select{padding-right:32px;cursor:pointer;}
.select-wrapper select:disabled{opacity:0.4;cursor:not-allowed;}

/* CITY AUTOCOMPLETE */
.address-wrapper{position:relative;margin-bottom:4px;}
.address-dropdown{position:absolute;top:calc(100% + 4px);left:0;right:0;background:white;border:1.5px solid var(--border-2);border-radius:10px;box-shadow:var(--shadow-md);z-index:99999;max-height:200px;overflow-y:auto;display:none;}
.address-dropdown.open{display:block;}
.address-option{padding:10px 14px;cursor:pointer;font-size:13px;color:var(--text-2);border-bottom:1px solid var(--border);transition:background 0.1s;}
.address-option:last-child{border-bottom:none;}
.address-option:hover,.address-option.highlighted{background:var(--blue-soft);color:var(--blue);}
.address-option .addr-main{font-weight:600;font-size:13px;}
.address-no-results{padding:14px;font-size:12px;color:var(--text-4);text-align:center;}
.city-selected-badge{display:none;align-items:center;gap:8px;background:var(--blue-soft);border:1.5px solid rgba(37,99,235,0.2);border-radius:9px;padding:9px 13px;margin-bottom:4px;}
.city-selected-badge .badge-icon{font-size:13px;}
.city-selected-badge .badge-text{flex:1;font-size:13px;color:var(--blue);font-weight:700;}
.city-selected-badge .badge-clear{cursor:pointer;color:rgba(37,99,235,0.4);font-size:15px;flex-shrink:0;}
.city-selected-badge .badge-clear:hover{color:var(--blue);}
</style>
</head>
<body>

<div id="toast-container"></div>

<div id="confirm-overlay">
  <div id="confirm-box">
    <div class="confirm-icon-wrap">🗑️</div>
    <h4 id="confirm-title">Delete Customer</h4>
    <p id="confirm-msg">Are you sure you want to delete this customer? This cannot be undone.</p>
    <div class="confirm-btns">
      <button class="btn-confirm-cancel" id="confirmNo">Cancel</button>
      <button class="btn-confirm-ok" id="confirmYes">Delete</button>
    </div>
  </div>
</div>

<div class="app-layout">
<jsp:include page="/WEB-INF/jsp/sidebar.jsp"/>

<div class="main">
  <div class="content">
    <div class="page-header">
      <div>
        <div class="breadcrumb">Dashboard <span>›</span> Management <span>›</span> Customers</div>
        <div class="page-title">Customers</div>
      </div>
      <button class="btn-primary" id="openAddCustomer">+ Add Customer</button>
    </div>

    <div class="stats-grid">
      <div class="stat-card blue">
        <div class="stat-icon-wrap">👥</div>
        <div class="stat-label">Total Customers</div>
        <div class="stat-value" id="statTotal">—</div>
        <div class="stat-sub"><span class="stat-up">↑ 12%</span> vs last month</div>
      </div>
      <div class="stat-card teal">
        <div class="stat-icon-wrap">✅</div>
        <div class="stat-label">Active</div>
        <div class="stat-value">—</div>
        <div class="stat-sub">Placed an order</div>
      </div>
      <div class="stat-card orange">
        <div class="stat-icon-wrap">🆕</div>
        <div class="stat-label">New This Month</div>
        <div class="stat-value">—</div>
        <div class="stat-sub"><span class="stat-up">↑ 8%</span> growth</div>
      </div>
      <div class="stat-card green">
        <div class="stat-icon-wrap">📍</div>
        <div class="stat-label">States Covered</div>
        <div class="stat-value">—</div>
        <div class="stat-sub">Across India</div>
      </div>
    </div>

    <div class="table-card">
      <div class="table-toolbar">
        <div class="table-toolbar-left">
          <span class="table-toolbar-title">All Customers</span>
          <span class="table-count-pill" id="customerCountLabel">—</span>
        </div>
        <div class="table-search">
          <span class="table-search-icon">🔍</span>
          <input type="text" id="tableSearch" placeholder="Search customers…">
        </div>
      </div>
      <table id="customersTable" class="display" style="width:100%">
        <thead><tr>
          <th>#</th>
          <th>Customer</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Address</th>
          <th></th>
        </tr></thead>
      </table>
    </div>
  </div>
</div><!-- /.main -->
</div><!-- /.app-layout -->

<div class="action-menu" id="actionMenu">
  <div class="edit-option">✏️ Edit Customer</div>
  <div class="delete-option">🗑️ Delete</div>
</div>

<!-- ADD MODAL -->
<div class="modal-overlay" id="addModal">
  <div class="modal-content">
    <button class="btn-close-modal" id="closeAddModal">✕</button>
    <div class="modal-header">
      <div class="modal-header-icon">👤</div>
      <div><h3>Add Customer</h3><p>Fill in the details to add a new customer</p></div>
    </div>
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
    <label>Email Address</label>
    <input type="text" id="addEmail" placeholder="john@example.com">
    <span class="field-error" id="errEmail">Enter a valid email address</span>
    <label>Phone Number</label>
    <input type="text" id="addPhone" placeholder="9876543210" maxlength="10">
    <span class="field-error" id="errPhone">Enter a valid 10-digit Indian mobile number</span>
    <label>State</label>
    <div class="select-wrapper"><select id="addState"><option value="">— Select State —</option></select></div>
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
    <div class="modal-header">
      <div class="modal-header-icon">✏️</div>
      <div><h3>Edit Customer</h3><p>Update customer information</p></div>
    </div>
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
    <label>Email Address</label>
    <input type="text" id="editEmail">
    <span class="field-error" id="errEditEmail">Enter a valid email address</span>
    <label>Phone Number</label>
    <input type="text" id="editPhone" maxlength="10">
    <span class="field-error" id="errEditPhone">Enter a valid 10-digit Indian mobile number</span>
    <label>State</label>
    <div class="select-wrapper"><select id="editState"><option value="">— Select State —</option></select></div>
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
const INDIA_DATA={"Andhra Pradesh":["Vijayawada","Visakhapatnam","Tirupati","Guntur","Kakinada","Kurnool","Rajamahendravaram","Nellore","Anantapur","Kadapa","Srikakulam","Vizianagaram","Eluru","Ongole","Chittoor","Hindupur","Tenali","Proddatur","Nandyal","Adoni"],"Arunachal Pradesh":["Itanagar","Naharlagun","Pasighat","Bomdila","Ziro","Along","Tezu","Roing"],"Assam":["Guwahati","Silchar","Dibrugarh","Jorhat","Nagaon","Tinsukia","Tezpur","Bongaigaon","Dhubri","Goalpara","Sivasagar","Golaghat","Karimganj"],"Bihar":["Patna","Gaya","Bhagalpur","Muzaffarpur","Purnia","Darbhanga","Bihar Sharif","Arrah","Begusarai","Katihar","Munger","Chhapra","Hajipur","Dehri","Siwan","Motihari","Nawada","Buxar","Kishanganj","Sitamarhi","Saharsa","Sasaram"],"Chandigarh":["Chandigarh"],"Chhattisgarh":["Raipur","Bhilai","Bilaspur","Korba","Durg","Rajnandgaon","Jagdalpur","Ambikapur","Raigarh","Dhamtari"],"Delhi":["New Delhi","Delhi","Dwarka","Rohini","Janakpuri","Laxmi Nagar","Shahdara","Karol Bagh","Pitampura","Saket","Vasant Kunj","Mayur Vihar","Uttam Nagar"],"Goa":["Panaji","Margao","Vasco da Gama","Mapusa","Ponda","Bicholim","Curchorem"],"Gujarat":["Ahmedabad","Surat","Vadodara","Rajkot","Bhavnagar","Jamnagar","Junagadh","Gandhinagar","Anand","Navsari","Morbi","Nadiad","Surendranagar","Bharuch","Mehsana","Bhuj","Porbandar","Palanpur","Valsad","Amreli","Botad","Dahod","Godhra","Himatnagar","Patan","Veraval","Gandhidham","Ankleshwar"],"Haryana":["Gurugram","Faridabad","Ambala","Hisar","Rohtak","Karnal","Panipat","Sonipat","Panchkula","Bhiwani","Sirsa","Bahadurgarh","Jind","Thanesar","Kaithal","Rewari","Palwal","Yamunanagar","Narnaul","Fatehabad"],"Himachal Pradesh":["Shimla","Dharamsala","Solan","Mandi","Palampur","Baddi","Nahan","Kullu","Hamirpur","Una","Chamba","Bilaspur"],"Jammu and Kashmir":["Srinagar","Jammu","Anantnag","Baramulla","Sopore","Kathua","Udhampur","Punch","Rajouri"],"Jharkhand":["Ranchi","Jamshedpur","Dhanbad","Bokaro","Deoghar","Hazaribagh","Giridih","Ramgarh","Chaibasa","Dumka"],"Karnataka":["Bengaluru","Mysuru","Hubballi","Mangaluru","Belagavi","Kalaburagi","Ballari","Vijayapura","Shivamogga","Tumakuru","Udupi","Dharwad","Bidar","Hassan","Raichur","Davanagere","Chitradurga","Bagalkot","Mandya","Gadag","Hosapete","Ramanagara"],"Kerala":["Thiruvananthapuram","Kochi","Kozhikode","Kollam","Thrissur","Palakkad","Alappuzha","Kannur","Kottayam","Malappuram","Kasaragod","Punalur","Angamaly","Tirur","Perinthalmanna"],"Ladakh":["Leh","Kargil"],"Madhya Pradesh":["Indore","Bhopal","Jabalpur","Gwalior","Ujjain","Sagar","Dewas","Satna","Ratlam","Rewa","Singrauli","Burhanpur","Khandwa","Bhind","Chhindwara","Guna","Shivpuri","Vidisha","Chhatarpur","Damoh","Mandsaur","Khargone","Neemuch","Pithampur","Hoshangabad","Itarsi","Sehore","Betul","Seoni"],"Maharashtra":["Mumbai","Pune","Nagpur","Nashik","Thane","Aurangabad","Solapur","Amravati","Kolhapur","Navi Mumbai","Sangli","Malegaon","Jalgaon","Akola","Latur","Dhule","Ahmednagar","Chandrapur","Parbhani","Ichalkaranji","Jalna","Bhiwandi","Panvel","Nanded","Ulhasnagar","Satara","Wardha","Yavatmal"],"Manipur":["Imphal","Thoubal","Kakching","Ukhrul","Churachandpur","Bishnupur"],"Meghalaya":["Shillong","Tura","Jowai","Nongpoh"],"Mizoram":["Aizawl","Lunglei","Saiha","Champhai","Kolasib"],"Nagaland":["Kohima","Dimapur","Mokokchung","Tuensang","Wokha","Zunheboto"],"Odisha":["Bhubaneswar","Cuttack","Rourkela","Brahmapur","Sambalpur","Puri","Balasore","Bhadrak","Baripada","Jharsuguda","Paradip","Angul","Kendujhar","Jeypore","Rayagada","Bolangir","Koraput","Sundargarh"],"Puducherry":["Puducherry","Karaikal","Mahe","Yanam"],"Punjab":["Ludhiana","Amritsar","Jalandhar","Patiala","Bathinda","Mohali","Hoshiarpur","Batala","Pathankot","Moga","Abohar","Malerkotla","Khanna","Phagwara","Muktsar","Barnala","Rajpura","Firozpur","Kapurthala","Ropar","Sangrur","Faridkot","Mansa"],"Rajasthan":["Jaipur","Jodhpur","Kota","Bikaner","Ajmer","Udaipur","Bhilwara","Alwar","Bharatpur","Sikar","Pali","Sri Ganganagar","Jhunjhunu","Kishangarh","Tonk","Beawar","Hanumangarh","Sawai Madhopur","Nagaur","Jhalawar","Barmer","Churu","Bundi","Rajsamand","Dungarpur","Banswara","Chittorgarh"],"Sikkim":["Gangtok","Namchi","Jorethang","Mangan"],"Tamil Nadu":["Chennai","Coimbatore","Madurai","Tiruchirappalli","Salem","Tirunelveli","Tiruppur","Vellore","Erode","Thoothukudi","Thanjavur","Dindigul","Kanchipuram","Nagercoil","Tiruvannamalai","Hosur","Karur","Kumbakonam","Cuddalore","Rajapalayam","Sivakasi","Pudukkottai","Nagapattinam","Namakkal","Krishnagiri","Virudhunagar"],"Telangana":["Hyderabad","Warangal","Nizamabad","Karimnagar","Khammam","Ramagundam","Mahbubnagar","Nalgonda","Adilabad","Suryapet","Siddipet","Bodhan","Jagtial","Mancherial","Nirmal","Kamareddy","Sangareddy","Wanaparthy","Nagarkurnool","Bhongir","Tandur"],"Tripura":["Agartala","Dharmanagar","Udaipur","Kailashahar","Belonia","Khowai","Ambassa"],"Uttar Pradesh":["Lucknow","Kanpur","Agra","Varanasi","Prayagraj","Ghaziabad","Noida","Meerut","Aligarh","Bareilly","Moradabad","Saharanpur","Gorakhpur","Faizabad","Jhansi","Mathura","Rampur","Shahjahanpur","Firozabad","Mau","Hapur","Etawah","Mirzapur","Bulandshahr","Sambhal","Amroha","Hardoi","Azamgarh","Bahraich","Sitapur","Muzaffarnagar","Jaunpur","Unnao","Rae Bareli"],"Uttarakhand":["Dehradun","Haridwar","Roorkee","Haldwani","Rudrapur","Kashipur","Rishikesh","Nainital","Mussoorie","Pithoragarh","Almora","Kotdwar","Ramnagar","Tehri","Pauri","Chamoli"],"West Bengal":["Kolkata","Asansol","Siliguri","Durgapur","Bardhaman","Malda","Baharampur","Habra","Kharagpur","Shantipur","Ranaghat","Haldia","Raiganj","Krishnanagar","Nabadwip","Medinipur","Jalpaiguri","Balurghat","Basirhat","Bankura","Chakdaha","Darjeeling","Alipurduar","Cooch Behar","Purulia","Kalna","Suri","Bishnupur","Tamluk","Contai","Ghatal"]};

const STATES=Object.keys(INDIA_DATA).sort((a,b)=>a.localeCompare(b));
const AV_COLORS=['av-0','av-1','av-2','av-3','av-4','av-5'];

function getInitials(n){return(n||'?').split(' ').filter(Boolean).map(w=>w[0]).join('').slice(0,2).toUpperCase();}
function getAvatarClass(n){let h=0;for(let c of(n||''))h=(h*31+c.charCodeAt(0))%6;return AV_COLORS[h];}
function populateStates(sel){sel.find('option:not(:first)').remove();STATES.forEach(s=>sel.append($('<option>').val(s).text(s)));}
function getCities(st){return(INDIA_DATA[st]||[]).slice().sort((a,b)=>a.localeCompare(b));}

function showToast(msg,type){
    const icons={success:'✅',error:'❌',info:'ℹ️'};
    const t=$('<div class="toast '+type+'"><span class="toast-icon">'+(icons[type]||'ℹ️')+'</span><span class="toast-msg">'+msg+'</span><button class="toast-close">✕</button></div>');
    $('#toast-container').append(t);
    requestAnimationFrame(()=>requestAnimationFrame(()=>t.addClass('show')));
    const tmr=setTimeout(()=>dismiss(t),3500);
    t.find('.toast-close').on('click',()=>{clearTimeout(tmr);dismiss(t);});
}
function dismiss(t){t.removeClass('show').addClass('hide');setTimeout(()=>t.remove(),350);}

function initCityAC(cfg){
    const{searchInput,dropdown,hiddenInput,badge,badgeText,clearBtn,fieldErr,wrapper}=cfg;
    let cityList=[],hlIdx=-1;
    function loadState(st){reset();cityList=getCities(st);searchInput.prop('disabled',!cityList.length).attr('placeholder',cityList.length?'Type city name…':'No cities for this state');}
    function getMatches(q){const l=q.toLowerCase();const s=cityList.filter(c=>c.toLowerCase().startsWith(l));const r=cityList.filter(c=>!c.toLowerCase().startsWith(l)&&c.toLowerCase().includes(l));return[...s,...r].slice(0,10);}
    function hl(text,q){if(!q)return text;const i=text.toLowerCase().indexOf(q.toLowerCase());if(i<0)return text;return text.slice(0,i)+'<strong style="color:#2563eb">'+text.slice(i,i+q.length)+'</strong>'+text.slice(i+q.length);}
    function render(matches,q){dropdown.empty();hlIdx=-1;if(!matches.length){dropdown.html('<div class="address-no-results">No cities found</div>');}else{matches.forEach(c=>$('<div class="address-option">').html('<div class="addr-main">'+hl(c,q)+'</div>').on('mousedown',e=>{e.preventDefault();pick(c);}).appendTo(dropdown));}dropdown.addClass('open');}
    function pick(city){hiddenInput.val(city);searchInput.val('');dropdown.removeClass('open').empty();badgeText.text(city);badge.css('display','flex');wrapper.hide();fieldErr.hide();}
    function preselect(city){if(!city)return;hiddenInput.val(city);badgeText.text(city);badge.css('display','flex');wrapper.hide();}
    clearBtn.on('click',()=>{hiddenInput.val('');badge.hide();wrapper.show();searchInput.val('').focus();});
    searchInput.on('input',function(){const q=$(this).val().trim();if(!q){dropdown.removeClass('open');return;}render(getMatches(q),q);});
    searchInput.on('keydown',function(e){const items=dropdown.find('.address-option');if(!items.length)return;if(e.key==='ArrowDown'){e.preventDefault();hlIdx=Math.min(hlIdx+1,items.length-1);items.removeClass('highlighted').eq(hlIdx).addClass('highlighted');}else if(e.key==='ArrowUp'){e.preventDefault();hlIdx=Math.max(hlIdx-1,0);items.removeClass('highlighted').eq(hlIdx).addClass('highlighted');}else if(e.key==='Enter'&&hlIdx>=0){e.preventDefault();items.eq(hlIdx).trigger('mousedown');}else if(e.key==='Escape'){dropdown.removeClass('open');}});
    searchInput.on('blur',()=>setTimeout(()=>dropdown.removeClass('open'),160));
    function reset(){hiddenInput.val('');searchInput.val('').prop('disabled',true).attr('placeholder','Select a state first…');dropdown.removeClass('open').empty();badge.hide();wrapper.show();fieldErr.hide();cityList=[];hlIdx=-1;}
    return{loadState,preselect,reset};
}

const RE_NAME=/^[a-zA-Z\s'\-]{2,50}$/;
const RE_EMAIL=/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
const RE_PHONE=/^[6-9]\d{9}$/;

function setErr(inp,err,show){if(show){$(inp).addClass('input-error');$(err).show();}else{$(inp).removeClass('input-error');$(err).hide();}}
function clearEditErrors(){$('#editError').hide().text('');['#editFirstName','#editLastName','#editEmail','#editPhone','#editState'].forEach(s=>$(s).removeClass('input-error'));['#errEditFirstName','#errEditLastName','#errEditEmail','#errEditPhone','#errEditState','#errEditCity'].forEach(s=>$(s).hide());}

$(document).ready(function(){
    let activeRowData=null,pendingDeleteId=null,pendingDeleteName='';

    populateStates($('#addState'));
    populateStates($('#editState'));

    const addCityAC=initCityAC({searchInput:$('#addCitySearch'),dropdown:$('#addCityDropdown'),hiddenInput:$('#addCity'),badge:$('#addCityBadge'),badgeText:$('#addCityBadgeText'),clearBtn:$('#clearAddCity'),fieldErr:$('#errCity'),wrapper:$('#addCityWrapper')});
    const editCityAC=initCityAC({searchInput:$('#editCitySearch'),dropdown:$('#editCityDropdown'),hiddenInput:$('#editCity'),badge:$('#editCityBadge'),badgeText:$('#editCityBadgeText'),clearBtn:$('#clearEditCity'),fieldErr:$('#errEditCity'),wrapper:$('#editCityWrapper')});

    $('#addState').on('change',function(){setErr('#addState','#errState',false);const s=$(this).val();if(s)addCityAC.loadState(s);else addCityAC.reset();});
    $('#editState').on('change',function(){setErr('#editState','#errEditState',false);const s=$(this).val();if(s)editCityAC.loadState(s);else editCityAC.reset();});

    const table=$('#customersTable').DataTable({
        serverSide:true,processing:true,
        ajax:{
            url:'/api/show-customers',type:'POST',
            data:function(d){return{draw:d.draw,start:d.start,length:d.length,search:d.search.value};},
            error:(xhr)=>console.error('DataTable error:',xhr.status,xhr.responseText)
        },
        columns:[
            {data:null,orderable:false,render:(d,t,r,meta)=>'<span style="font-family:\'JetBrains Mono\',monospace;font-size:11px;color:var(--text-4);font-weight:500">'+(meta.settings._iDisplayStart+meta.row+1)+'</span>'},
            {data:'fullName',render:(d,t,r)=>{const av=getAvatarClass(d||'');return'<div class="name-cell"><div class="customer-avatar '+av+'">'+getInitials(d||'?')+'</div><span style="font-weight:700;color:var(--text);font-size:14px">'+(d||'—')+'</span></div>';}},
            {data:'email',render:(d)=>'<span class="mono">'+(d||'—')+'</span>'},
            {data:'phoneNumber',render:(d)=>'<span class="mono">'+(d||'—')+'</span>'},
            {data:'address',orderable:false,createdCell:(td)=>$(td).addClass('address-cell'),render:(data)=>{const a=data||'—';return'<span title="'+$('<div>').text(a).html()+'">'+$('<div>').text(a).html()+'</span>';}},
            {data:null,orderable:false,render:()=>'<span class="edit-icon">⋯</span>'}
        ],
        dom:'rtip',
        autoWidth:false,
        columnDefs:[
            {width:'44px',targets:0},
            {width:'20%',targets:1},
            {width:'22%',targets:2},
            {width:'14%',targets:3},
            {width:'30%',targets:4},
            {width:'44px',targets:5}
        ],
        drawCallback:function(settings){
            const total=settings.fnRecordsTotal();
            $('#customerCountLabel').text(total+' total record'+(total!==1?'s':''));
            $('#statTotal').text(total);
        }
    });

    $('#tableSearch').on('input',function(){table.search($(this).val()).draw();});

    $(document).on('click','.edit-icon',function(e){
        e.stopPropagation();
        activeRowData=table.row($(this).closest('tr')).data();
        if(!activeRowData)return;
        const off=$(this).offset();
        $('#actionMenu').css({top:(off.top+$(this).outerHeight()+4)+'px',left:(off.left-120)+'px'}).show();
    });
    $(document).on('click',()=>$('#actionMenu').hide());

    // ADD
    $('#openAddCustomer').on('click',()=>{resetAddModal();$('#addModal').addClass('active');});
    function closeAddModal(){$('#addModal').removeClass('active');resetAddModal();}
    function resetAddModal(){
        $('#addFirstName,#addLastName,#addEmail,#addPhone').val('').removeClass('input-error');
        $('#addState').val('').removeClass('input-error');
        $('#errFirstName,#errLastName,#errEmail,#errPhone,#errState,#errCity').hide();
        $('#addError').hide().text('');$('#addSuccess').hide().text('');
        $('#submitAdd').prop('disabled',false).text('Add Customer');
        addCityAC.reset();
    }
    $('#addFirstName').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#addFirstName','#errFirstName',!RE_NAME.test(v));});
    $('#addLastName').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#addLastName','#errLastName',!RE_NAME.test(v));});
    $('#addEmail').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#addEmail','#errEmail',!RE_EMAIL.test(v));});
    $('#addPhone').on('input',function(){$(this).val($(this).val().replace(/\D/g,''));});
    $('#addPhone').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#addPhone','#errPhone',!RE_PHONE.test(v));});
    $('#closeAddModal,#cancelAdd').on('click',closeAddModal);
    $('#addModal').on('click',function(e){if($(e.target).is('#addModal'))closeAddModal();});

    $('#submitAdd').on('click',function(){
        $('#addError').hide();
        const fn=($('#addFirstName').val()||'').trim(),ln=($('#addLastName').val()||'').trim();
        const em=($('#addEmail').val()||'').trim(),ph=($('#addPhone').val()||'').trim();
        const state=$('#addState').val(),city=($('#addCity').val()||'').trim();
        const addr=(city&&state)?city+', '+state:'';
        let ok=true;
        if(!fn||!RE_NAME.test(fn)){setErr('#addFirstName','#errFirstName',true);ok=false;}
        if(!ln||!RE_NAME.test(ln)){setErr('#addLastName','#errLastName',true);ok=false;}
        if(!em||!RE_EMAIL.test(em)){setErr('#addEmail','#errEmail',true);ok=false;}
        if(!ph||!RE_PHONE.test(ph)){setErr('#addPhone','#errPhone',true);ok=false;}
        if(!state){setErr('#addState','#errState',true);ok=false;}
        if(!city){$('#errCity').show();ok=false;}
        if(!ok)return;
        $('#submitAdd').prop('disabled',true).text('Saving…');
        $.ajax({
            url:'/api/customer-save',type:'POST',contentType:'application/json',
            data:JSON.stringify({firstName:fn,lastName:ln,email:em,phoneNumber:ph,address:addr}),
            success:(res)=>{table.ajax.reload(null,false);closeAddModal();showToast(res.message||'Customer added successfully!','success');},
            error:(xhr)=>{
                let msg='Failed to add customer.';
                try{const e=JSON.parse(xhr.responseText);msg=e.errors?Object.values(e.errors).join(' '):e.message||e.error||msg;}catch(_){}
                $('#addError').text(msg).show();
                $('#submitAdd').prop('disabled',false).text('Add Customer');
            }
        });
    });

    // EDIT
    $(document).on('click','.edit-option',function(e){
        e.stopPropagation();$('#actionMenu').hide();
        if(!activeRowData){showToast('No row selected','error');return;}
        clearEditErrors();editCityAC.reset();
        $('#editId').val(activeRowData.id);
        $('#editFirstName').val(activeRowData.firstName||'');
        $('#editLastName').val(activeRowData.lastName||'');
        $('#editEmail').val(activeRowData.email||'');
        $('#editPhone').val(activeRowData.phoneNumber||'');
        const addr=activeRowData.address||'';
        if(addr.includes(',')){
            const city=addr.split(',')[0].trim();
            const state=addr.split(',').slice(1).join(',').trim();
            if(state&&INDIA_DATA[state]){$('#editState').val(state);editCityAC.loadState(state);editCityAC.preselect(city);}
        }
        $('#editModal').addClass('active');
    });
    function closeEditModal(){$('#editModal').removeClass('active');$('#editSpinner').removeClass('active');clearEditErrors();editCityAC.reset();$('#editState').val('');}
    $('#closeEditModal,#cancelEdit').on('click',closeEditModal);
    $('#editModal').on('click',function(e){if($(e.target).is('#editModal'))closeEditModal();});
    $('#editPhone').on('input',function(){$(this).val($(this).val().replace(/\D/g,''));});
    $('#editFirstName').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#editFirstName','#errEditFirstName',!RE_NAME.test(v));});
    $('#editLastName').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#editLastName','#errEditLastName',!RE_NAME.test(v));});
    $('#editEmail').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#editEmail','#errEditEmail',!RE_EMAIL.test(v));});
    $('#editPhone').on('blur',function(){const v=$(this).val().trim();if(v)setErr('#editPhone','#errEditPhone',!RE_PHONE.test(v));});

    $('#saveEdit').on('click',function(){
        clearEditErrors();
        const id=$('#editId').val();
        const fn=($('#editFirstName').val()||'').trim(),ln=($('#editLastName').val()||'').trim();
        const em=($('#editEmail').val()||'').trim(),ph=($('#editPhone').val()||'').trim();
        const state=$('#editState').val(),city=($('#editCity').val()||'').trim();
        const addr=(city&&state)?city+', '+state:'';
        let ok=true;
        if(!fn||!RE_NAME.test(fn)){setErr('#editFirstName','#errEditFirstName',true);ok=false;}
        if(!ln||!RE_NAME.test(ln)){setErr('#editLastName','#errEditLastName',true);ok=false;}
        if(!em||!RE_EMAIL.test(em)){setErr('#editEmail','#errEditEmail',true);ok=false;}
        if(ph&&!RE_PHONE.test(ph)){setErr('#editPhone','#errEditPhone',true);ok=false;}
        if(!state){setErr('#editState','#errEditState',true);ok=false;}
        if(!city){$('#errEditCity').show();ok=false;}
        if(!ok)return;
        $.ajax({
            url:'/api/customer-update/'+id,type:'PUT',contentType:'application/json',
            data:JSON.stringify({firstName:fn,lastName:ln,email:em,phoneNumber:ph,address:addr}),
            success:(res)=>{closeEditModal();table.ajax.reload(null,false);showToast(res.message||'Customer updated successfully!','success');},
            error:(xhr)=>{
                let msg='Update failed.';
                try{const e=JSON.parse(xhr.responseText);msg=e.errors?Object.values(e.errors).join(' '):e.message||e.error||msg;}catch(_){}
                $('#editError').text(msg).show();
            }
        });
    });

    // DELETE
    $(document).on('click','.delete-option',function(e){
        e.stopPropagation();$('#actionMenu').hide();
        if(!activeRowData){showToast('No row selected','error');return;}
        pendingDeleteId=parseInt(activeRowData.id);
        pendingDeleteName=((activeRowData.firstName||'')+' '+(activeRowData.lastName||'')).trim();
        if(isNaN(pendingDeleteId)){showToast('Could not resolve customer ID','error');return;}
        $('#confirm-msg').text('Are you sure you want to delete "'+pendingDeleteName+'"? This cannot be undone.');
        $('#confirm-overlay').addClass('active');
    });
    $('#confirmNo').on('click',()=>{$('#confirm-overlay').removeClass('active');pendingDeleteId=null;});
    $('#confirm-overlay').on('click',function(e){if($(e.target).is('#confirm-overlay')){$('#confirm-overlay').removeClass('active');pendingDeleteId=null;}});
    $('#confirmYes').on('click',function(){
        $('#confirm-overlay').removeClass('active');
        if(!pendingDeleteId)return;
        const id=pendingDeleteId;pendingDeleteId=null;
        $.ajax({
            url:'/api/customer-delete/'+id,type:'DELETE',
            success:(res)=>{activeRowData=null;table.ajax.reload(null,false);showToast(res.message||'Customer deleted!','success');},
            error:()=>showToast('Delete failed — please try again.','error')
        });
    });
});
</script>
</body>
</html>
