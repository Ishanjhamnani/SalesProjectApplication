<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Products — SalesPanel</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<style>
:root {
    --bg:#f0f4fa; --surface:#ffffff; --surface-2:#f8faff;
    --border:rgba(99,115,155,0.12); --border-2:rgba(99,115,155,0.20);
    --blue:#2563eb; --blue-soft:#eff4ff; --blue-glow:rgba(37,99,235,0.15); --indigo:#4f46e5;
    --teal:#0d9488; --orange:#ea580c; --green:#16a34a; --green-soft:#f0fdf4;
    --red:#dc2626; --red-soft:#fff1f1; --danger:#dc2626; --danger-glow:rgba(220,38,38,0.12);
    --amber:#d97706; --amber-soft:#fffbeb;
    --text:#0f172a; --text-dim:#334155; --text-muted:#64748b;
    --radius:12px; --radius-sm:8px;
    --shadow:0 1px 3px rgba(15,23,42,0.06),0 4px 16px rgba(15,23,42,0.06);
    --shadow-md:0 4px 24px rgba(15,23,42,0.10);
    --shadow-lg:0 8px 40px rgba(15,23,42,0.14);
}
/* Re-declare under .content so sidebar vars cannot override ours */
.content {
    --bg:#f0f4fa; --surface:#ffffff; --surface-2:#f8faff;
    --border:rgba(99,115,155,0.12); --border-2:rgba(99,115,155,0.20);
    --blue:#2563eb; --blue-soft:#eff4ff; --blue-glow:rgba(37,99,235,0.15); --indigo:#4f46e5;
    --teal:#0d9488; --orange:#ea580c; --green:#16a34a; --green-soft:#f0fdf4;
    --red:#dc2626; --red-soft:#fff1f1; --danger:#dc2626; --danger-glow:rgba(220,38,38,0.12);
    --amber:#d97706; --amber-soft:#fffbeb;
    --text:#0f172a; --text-dim:#334155; --text-muted:#64748b;
    --radius:12px; --radius-sm:8px;
    --shadow:0 1px 3px rgba(15,23,42,0.06),0 4px 16px rgba(15,23,42,0.06);
    --shadow-md:0 4px 24px rgba(15,23,42,0.10);
    --shadow-lg:0 8px 40px rgba(15,23,42,0.14);
}
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);min-height:100vh;overflow-x:hidden;}
.container{display:flex;min-height:100vh;}
.content{flex:1;padding:32px 36px;min-width:0;}
.page-header{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:28px;}
.page-eyebrow{font-family:'JetBrains Mono',monospace;font-size:10px;letter-spacing:0.14em;color:var(--blue);text-transform:uppercase;margin-bottom:4px;font-weight:500;}
.page-title{font-size:26px;font-weight:800;color:var(--text);letter-spacing:-0.04em;line-height:1;}
.page-subtitle{font-family:'JetBrains Mono',monospace;font-size:11px;color:var(--text-muted);margin-top:6px;letter-spacing:0.03em;}
.btn-primary{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;background:linear-gradient(135deg,var(--blue),var(--indigo));color:white;border:none;border-radius:var(--radius-sm);cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-weight:700;font-size:13px;transition:all 0.18s ease;box-shadow:0 4px 14px var(--blue-glow);}
.btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(37,99,235,0.30);}
.btn-primary:active{transform:translateY(0);}
.table-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);overflow:visible;box-shadow:var(--shadow);}
.table-card .dataTables_wrapper{border-radius:var(--radius);overflow:hidden;}
.dataTables_wrapper{padding:0;color:var(--text);}
.dataTables_wrapper .dataTables_length,.dataTables_wrapper .dataTables_filter,.dataTables_wrapper .dataTables_info,.dataTables_wrapper .dataTables_paginate{padding:14px 20px;}
div.dataTables_wrapper div.dataTables_length{float:left;background:var(--surface-2);}
div.dataTables_wrapper div.dataTables_filter{float:right;background:var(--surface-2);}
.dataTables_wrapper::after{content:'';display:table;clear:both;border-bottom:1px solid var(--border);}
div.dataTables_wrapper div.dataTables_length select{background:var(--surface);border:1.5px solid var(--border-2);color:var(--text);border-radius:var(--radius-sm);padding:4px 8px;font-family:'JetBrains Mono',monospace;font-size:11px;outline:none;}
div.dataTables_wrapper div.dataTables_filter input{background:var(--surface);border:1.5px solid var(--border-2);color:var(--text);border-radius:var(--radius-sm);padding:7px 12px;font-family:'JetBrains Mono',monospace;font-size:12px;outline:none;width:220px;transition:border-color 0.18s;}
div.dataTables_wrapper div.dataTables_filter input:focus{border-color:var(--blue);box-shadow:0 0 0 3px var(--blue-glow);}
div.dataTables_wrapper div.dataTables_filter input::placeholder{color:var(--text-muted);}
table.dataTable{border-collapse:collapse !important;width:100% !important;margin:0 !important;}
table.dataTable thead th{background:var(--surface-2);color:var(--text-muted);font-family:'JetBrains Mono',monospace;font-size:10px;letter-spacing:0.10em;text-transform:uppercase;font-weight:500;padding:12px 16px;border-bottom:1px solid var(--border);border-top:none;white-space:nowrap;}
table.dataTable thead th.sorting,table.dataTable thead th.sorting_asc,table.dataTable thead th.sorting_desc{background:var(--surface-2);}
table.dataTable tbody tr{background:var(--surface);transition:background 0.12s;}
table.dataTable tbody tr:hover{background:#f5f8ff;}
table.dataTable tbody td{padding:13px 16px;border-bottom:1px solid var(--border);font-size:13.5px;color:var(--text-dim);vertical-align:middle;}
table.dataTable tbody tr:last-child td{border-bottom:none;}
div.dataTables_wrapper div.dataTables_info{font-family:'JetBrains Mono',monospace;font-size:11px;color:var(--text-muted);border-top:1px solid var(--border);background:var(--surface-2);}
div.dataTables_wrapper div.dataTables_paginate{border-top:1px solid var(--border);background:var(--surface-2);}
div.dataTables_wrapper div.dataTables_paginate .paginate_button{font-family:'JetBrains Mono',monospace;font-size:11px;color:var(--text-muted) !important;border-radius:var(--radius-sm) !important;border:1px solid transparent !important;padding:5px 10px !important;transition:all 0.15s !important;}
div.dataTables_wrapper div.dataTables_paginate .paginate_button:hover{background:var(--blue-soft) !important;border-color:rgba(37,99,235,0.2) !important;color:var(--blue) !important;}
div.dataTables_wrapper div.dataTables_paginate .paginate_button.current,div.dataTables_wrapper div.dataTables_paginate .paginate_button.current:hover{background:linear-gradient(135deg,var(--blue),var(--indigo)) !important;border-color:var(--blue) !important;color:white !important;box-shadow:0 4px 12px var(--blue-glow) !important;}
div.dataTables_wrapper div.dataTables_paginate .paginate_button.disabled,div.dataTables_wrapper div.dataTables_paginate .paginate_button.disabled:hover{color:var(--text-muted) !important;}
/* Stock badges */
.stock-badge{display:inline-flex;align-items:center;gap:5px;padding:4px 10px;border-radius:999px;font-family:'JetBrains Mono',monospace;font-size:10px;font-weight:600;letter-spacing:0.05em;}
.stock-badge::before{content:'';width:5px;height:5px;border-radius:50%;flex-shrink:0;}
.stock-ok{background:var(--green-soft);color:var(--green);border:1.5px solid rgba(22,163,74,0.2);}
.stock-ok::before{background:var(--green);}
.stock-low{background:var(--amber-soft);color:var(--amber);border:1.5px solid rgba(217,119,6,0.2);}
.stock-low::before{background:var(--amber);}
.stock-out{background:var(--red-soft);color:var(--red);border:1.5px solid rgba(220,38,38,0.2);}
.stock-out::before{background:var(--red);}
/* Action menu */
.edit-icon{cursor:pointer;display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:7px;background:var(--surface-2);border:1px solid var(--border-2);font-size:14px;transition:all 0.15s;user-select:none;color:var(--text-muted);}
.edit-icon:hover{background:var(--blue-soft);border-color:rgba(37,99,235,0.25);color:var(--blue);}
.action-menu{position:fixed;background:var(--surface);border:1px solid var(--border-2);border-radius:var(--radius);display:none;z-index:9999;min-width:160px;box-shadow:var(--shadow-lg);overflow:hidden;padding:6px;}
.action-menu div{padding:9px 12px;cursor:pointer;color:var(--text-dim);font-size:13px;font-weight:600;display:flex;align-items:center;gap:8px;transition:background 0.12s;border-radius:var(--radius-sm);}
.action-menu div:hover{background:var(--surface-2);color:var(--text);}
.action-menu .delete-option{color:var(--red);}
.action-menu .delete-option:hover{background:var(--red-soft);color:var(--red);}
/* Toast */
#toast-container{position:fixed;top:20px;right:20px;z-index:99999;display:flex;flex-direction:column;gap:10px;pointer-events:none;}
.toast{display:flex;align-items:center;gap:12px;min-width:280px;max-width:380px;padding:14px 16px;border-radius:var(--radius);font-size:13px;font-weight:600;color:white;box-shadow:var(--shadow-lg);pointer-events:all;opacity:0;transform:translateX(40px);transition:opacity 0.3s ease,transform 0.3s ease;}
.toast.show{opacity:1;transform:translateX(0);}
.toast.hide{opacity:0;transform:translateX(40px);}
.toast.success{background:linear-gradient(135deg,#16a34a,#15803d);}
.toast.error{background:linear-gradient(135deg,#dc2626,#b91c1c);}
.toast.info{background:linear-gradient(135deg,var(--blue),var(--indigo));}
.toast-icon{font-size:16px;flex-shrink:0;}
.toast-msg{flex:1;line-height:1.4;}
.toast-close{cursor:pointer;opacity:0.7;font-size:15px;flex-shrink:0;background:none;border:none;color:white;padding:0;}
/* Confirm */
#confirm-overlay{display:none;position:fixed;inset:0;background:rgba(15,23,42,0.55);z-index:20000;align-items:center;justify-content:center;backdrop-filter:blur(6px);}
#confirm-overlay.active{display:flex;}
#confirm-box{background:#ffffff !important;border:1px solid rgba(99,115,155,0.18);border-radius:16px;padding:32px;width:360px;max-width:92vw;box-shadow:0 24px 80px rgba(15,23,42,0.18);text-align:center;animation:popIn 0.2s cubic-bezier(0.34,1.56,0.64,1);}
@keyframes popIn{from{transform:scale(0.9);opacity:0;}to{transform:scale(1);opacity:1;}}
#confirm-box .confirm-icon{width:58px;height:58px;background:var(--red-soft);border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:26px;margin:0 auto 16px;}
#confirm-box h4{font-size:17px;font-weight:800;color:var(--text);margin-bottom:8px;letter-spacing:-0.02em;}
#confirm-box p{font-size:13px;color:var(--text-muted);line-height:1.6;margin-bottom:24px;}
.confirm-btns{display:flex;gap:10px;}
.btn-confirm-cancel{flex:1;padding:11px;background:#f1f5f9 !important;color:#334155 !important;border:1.5px solid #cbd5e1 !important;border-radius:var(--radius-sm);cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;font-weight:700;transition:all 0.15s;}
.btn-confirm-cancel:hover{background:#e2e8f0 !important;}
.btn-confirm-ok{flex:1;padding:11px;background:var(--red);color:white;border:none;border-radius:var(--radius-sm);cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;font-weight:700;transition:all 0.15s;}
.btn-confirm-ok:hover{background:#b91c1c;box-shadow:0 4px 14px rgba(220,38,38,0.3);}
/* Modals */
.modal-overlay{display:none;position:fixed;inset:0;background:rgba(15,23,42,0.55);z-index:10000;align-items:center;justify-content:center;backdrop-filter:blur(6px);}
.modal-overlay.active{display:flex;}
.modal-content{background:#ffffff !important;border:1px solid rgba(99,115,155,0.18);color:#0f172a !important;border-radius:16px;padding:28px;width:500px;max-width:95vw;position:relative;max-height:90vh;overflow-y:auto;animation:popIn 0.2s cubic-bezier(0.34,1.56,0.64,1);box-shadow:0 24px 80px rgba(15,23,42,0.16);}
.modal-content::-webkit-scrollbar{width:4px;}
.modal-content::-webkit-scrollbar-thumb{background:rgba(99,115,155,0.18);border-radius:2px;}
.modal-content h3{margin:0 0 22px 0;font-size:17px;font-weight:800;letter-spacing:-0.02em;color:#0f172a !important;border-bottom:1px solid rgba(99,115,155,0.12);padding-bottom:14px;}
.modal-content label{display:block !important;font-family:'JetBrains Mono',monospace !important;font-size:11px !important;font-weight:600 !important;color:#64748b !important;margin-bottom:6px !important;margin-top:10px !important;text-transform:uppercase !important;letter-spacing:0.08em !important;}
.modal-content input,.modal-content textarea{width:100%;padding:10px 13px;margin-bottom:16px;border-radius:var(--radius-sm);border:1.5px solid #cbd5e1 !important;font-size:13.5px;color:#0f172a !important;background:#f8faff !important;font-family:'Plus Jakarta Sans',sans-serif;transition:border-color 0.15s,box-shadow 0.15s;outline:none;}
.modal-content textarea{resize:vertical;min-height:80px;font-family:'Plus Jakarta Sans',sans-serif;}
.modal-content input::placeholder,.modal-content textarea::placeholder{color:#94a3b8 !important;}
.modal-content input:focus,.modal-content textarea:focus{border-color:#2563eb !important;box-shadow:0 0 0 3px rgba(37,99,235,0.15) !important;background:#ffffff !important;}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:12px;}
.form-row .form-group{display:flex;flex-direction:column;}
.form-row .form-group input{margin-bottom:0;}
.modal-buttons{display:flex;gap:10px;margin-top:6px;}
.btn-save{flex:1;padding:11px;background:linear-gradient(135deg,var(--blue),var(--indigo));color:white;border:none;border-radius:var(--radius-sm);cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;font-weight:700;transition:all 0.15s;box-shadow:0 4px 14px var(--blue-glow);}
.btn-save:hover{transform:translateY(-1px);box-shadow:0 8px 22px rgba(37,99,235,0.28);}
.btn-save:disabled{background:#c7d2fe;cursor:not-allowed;box-shadow:none;transform:none;}
.btn-cancel{flex:1;padding:11px;background:#f1f5f9 !important;color:#334155 !important;border:1.5px solid #cbd5e1 !important;border-radius:var(--radius-sm);cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;font-weight:700;transition:all 0.15s;}
.btn-cancel:hover{background:#e2e8f0 !important;}
.btn-close-modal{position:absolute;top:18px;right:18px;background:var(--surface-2);border:1px solid var(--border-2);border-radius:7px;width:28px;height:28px;display:flex;align-items:center;justify-content:center;font-size:14px;cursor:pointer;color:var(--text-muted);transition:all 0.15s;}
.btn-close-modal:hover{background:var(--bg);color:var(--text);}
.modal-error{background:var(--red-soft);color:var(--red);border:1.5px solid rgba(220,38,38,0.2);border-radius:var(--radius-sm);padding:10px 14px;font-size:12px;margin-bottom:16px;display:none;font-family:'JetBrains Mono',monospace;font-weight:500;}
.modal-success{background:var(--green-soft);color:var(--green);border:1.5px solid rgba(22,163,74,0.2);border-radius:var(--radius-sm);padding:10px 14px;font-size:12px;margin-bottom:16px;display:none;font-family:'JetBrains Mono',monospace;font-weight:500;}
.modal-spinner{display:none;position:absolute;inset:0;background:rgba(255,255,255,0.8);border-radius:16px;align-items:center;justify-content:center;font-size:13px;color:var(--text-muted);font-family:'JetBrains Mono',monospace;z-index:1;backdrop-filter:blur(4px);}
.modal-spinner.active{display:flex;}
.price-cell{font-family:'JetBrains Mono',monospace;font-size:13px;font-weight:600;color:var(--text);}
.sku-cell{font-family:'JetBrains Mono',monospace;font-size:11px;color:var(--text-muted);letter-spacing:0.04em;}
</style>
</head>
<body>
<div id="toast-container"></div>
<div id="confirm-overlay">
    <div id="confirm-box">
        <div class="confirm-icon">🗑️</div>
        <h4 id="confirm-title">Delete Product</h4>
        <p id="confirm-msg">Are you sure you want to delete this product? This cannot be undone.</p>
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
            <div>
                <div class="page-eyebrow">Inventory</div>
                <div class="page-title">Products</div>
                <div class="page-subtitle" id="productCountLabel">Loading records…</div>
            </div>
            <button class="btn-primary" id="openAddProduct">+ Add Product</button>
        </div>
        <div class="table-card">
            <table id="productsTable" class="display" style="width:100%">
                <thead><tr>
                    <th>#</th><th>SKU</th><th>Name</th><th>Category</th><th>Price</th><th>Stock</th><th></th>
                </tr></thead>
            </table>
        </div>
    </div>
</div>
<div class="action-menu" id="actionMenu">
    <div class="edit-option">✏️ Edit</div>
    <div class="delete-option">🗑️ Delete</div>
</div>
<!-- ADD PRODUCT MODAL -->
<div class="modal-overlay" id="addModal">
    <div class="modal-content">
        <button class="btn-close-modal" id="closeAddModal">✕</button>
        <h3>📦 Add Product</h3>
        <div class="modal-error" id="addError"></div>
        <div class="modal-success" id="addSuccess"></div>
        <div class="form-row">
            <div class="form-group"><label>SKU</label><input type="text" id="addSku" placeholder="SKU-001"></div>
            <div class="form-group"><label>Category</label><input type="text" id="addCategory" placeholder="Electronics"></div>
        </div>
        <label>Product Name</label>
        <input type="text" id="addName" placeholder="Product name">
        <label>Description</label>
        <textarea id="addDescription" placeholder="Optional product description…"></textarea>
        <div class="form-row">
            <div class="form-group"><label>Price (₹)</label><input type="number" id="addPrice" placeholder="0.00" min="0" step="0.01"></div>
            <div class="form-group"><label>Stock Quantity</label><input type="number" id="addStock" placeholder="0" min="0" value="0"></div>
        </div>
        <div class="modal-buttons">
            <button class="btn-save" id="submitAdd">Add Product</button>
            <button class="btn-cancel" id="cancelAdd">Cancel</button>
        </div>
    </div>
</div>
<!-- EDIT PRODUCT MODAL -->
<div class="modal-overlay" id="editModal">
    <div class="modal-content">
        <div class="modal-spinner" id="editSpinner">Loading…</div>
        <button class="btn-close-modal" id="closeEditModal">✕</button>
        <h3>✏️ Edit Product</h3>
        <input type="hidden" id="editId">
        <div class="modal-error" id="editError"></div>
        <div class="form-row">
            <div class="form-group"><label>SKU</label><input type="text" id="editSku"></div>
            <div class="form-group"><label>Category</label><input type="text" id="editCategory"></div>
        </div>
        <label>Product Name</label>
        <input type="text" id="editName">
        <div class="form-row">
            <div class="form-group"><label>Price (₹)</label><input type="number" id="editPrice" min="0" step="0.01"></div>
            <div class="form-group"><label>Stock Quantity</label><input type="number" id="editStock" min="0"></div>
        </div>
        <div class="modal-buttons" style="margin-top:6px;">
            <button class="btn-save" id="saveEdit">Save Changes</button>
            <button class="btn-cancel" id="cancelEdit">Cancel</button>
        </div>
    </div>
</div>
<script>
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

$(document).ready(function(){

    let activeRowData   = null;
    let pendingDeleteId = null;
    let pendingDeleteName = '';

    const table = $('#productsTable').DataTable({
        serverSide: true,
        processing: true,
        ajax: {
            url: '/api/show-products',
            type: 'GET',
            data: function(d) {
                return { draw:d.draw, start:d.start, length:d.length, search:d.search.value };
            },
            error: function(xhr){ console.error('Products AJAX:', xhr.status, xhr.responseText); }
        },
        columns: [
            { data:null, orderable:false, render:(d,t,r,meta) =>
                '<span style="font-family:\'JetBrains Mono\',monospace;font-size:11px;color:var(--text-muted)">'+(meta.settings._iDisplayStart+meta.row+1)+'</span>'
            },
            { data:'sku', render:(v) =>
                '<span class="sku-cell">'+(v||'—')+'</span>'
            },
            { data:'name', render:(v) =>
                '<span style="font-weight:700;color:var(--text)">'+(v||'—')+'</span>'
            },
            { data:'category', render:(v) => {
                if (!v) return '<span style="color:var(--text-muted)">—</span>';
                return '<span style="display:inline-block;padding:3px 10px;border-radius:999px;background:var(--surface-2);border:1.5px solid var(--border-2);font-size:11px;font-family:\'JetBrains Mono\',monospace;color:var(--text-muted)">'+v+'</span>';
            }},
            { data:'currentPrice', render:(v) =>
                '<span class="price-cell">₹'+parseFloat(v||0).toFixed(2)+'</span>'
            },
            { data:'stockQuantity', render:function(qty){
                let cls='stock-ok', label=qty;
                if(qty===0)     { cls='stock-out'; label='Out of stock'; }
                else if(qty<10) { cls='stock-low'; label=qty+' (Low)'; }
                return '<span class="stock-badge '+cls+'">'+label+'</span>';
            }},
            { data:null, orderable:false, render:() => '<span class="edit-icon">⋯</span>' }
        ],
        dom: 'rtip',
        autoWidth: false,
        columnDefs: [
            { width: '40px', targets: 0 },
            { width: '12%',  targets: 1 },
            { width: '26%',  targets: 2 },
            { width: '16%',  targets: 3 },
            { width: '14%',  targets: 4 },
            { width: '14%',  targets: 5 },
            { width: '50px', targets: 6 }
        ],
        drawCallback: function(settings) {
            const total = settings.fnRecordsTotal();
            $('#productCountLabel').text(total + ' total product' + (total !== 1 ? 's' : ''));
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

    $('#openAddProduct').on('click', function(){ resetAddModal(); $('#addModal').addClass('active'); });

    function closeAddModal(){ $('#addModal').removeClass('active'); resetAddModal(); }
    function resetAddModal(){
        $('#addSku,#addName,#addCategory,#addDescription').val('');
        $('#addPrice').val(''); $('#addStock').val('0');
        $('#addError').hide().text(''); $('#addSuccess').hide().text('');
        $('#submitAdd').prop('disabled',false).text('Add Product');
    }

    $('#closeAddModal,#cancelAdd').on('click', closeAddModal);
    $('#addModal').on('click', function(e){ if($(e.target).is('#addModal')) closeAddModal(); });

    $('#submitAdd').on('click', function(){
        $('#addError').hide();
        const sku      = $('#addSku').val().trim();
        const name     = $('#addName').val().trim();
        const category = $('#addCategory').val().trim();
        const desc     = $('#addDescription').val().trim();
        const price    = parseFloat($('#addPrice').val());
        const stock    = parseInt($('#addStock').val());

        if(!sku)                      { showAddError('SKU is required.'); return; }
        if(!name)                     { showAddError('Product name is required.'); return; }
        if(isNaN(price)||price<0)     { showAddError('Enter a valid price (0 or greater).'); return; }
        if(isNaN(stock)||stock<0)     { showAddError('Stock quantity cannot be negative.'); return; }

        const payload = { sku, name, category:category||null, description:desc||null, currentPrice:price, stockQuantity:stock };
        $('#submitAdd').prop('disabled',true).text('Saving…');

        $.ajax({
            url:'/api/product-save', type:'POST', contentType:'application/json',
            data: JSON.stringify(payload),
            success: function(res){
                $('#addSuccess').text(res.message||'Product added successfully!').show();
                table.ajax.reload(null,false);
                setTimeout(closeAddModal, 1200);
            },
            error: function(xhr){
                let msg='Failed to add product.';
                try { const e=JSON.parse(xhr.responseText); msg=e.errors?Object.values(e.errors).join(' '):e.message||e.error||msg; } catch(_){}
                showAddError(msg);
                $('#submitAdd').prop('disabled',false).text('Add Product');
            }
        });
    });

    function showAddError(msg){ $('#addError').text(msg).show(); }

    $(document).on('click', '.edit-option', function(e){
        e.stopPropagation(); $('#actionMenu').hide();
        if(!activeRowData){ showToast('No row selected','error'); return; }
        $('#editId').val(activeRowData.id);
        $('#editSku').val(activeRowData.sku||'');
        $('#editName').val(activeRowData.name||'');
        $('#editCategory').val(activeRowData.category||'');
        $('#editPrice').val(activeRowData.currentPrice!=null?activeRowData.currentPrice:'');
        $('#editStock').val(activeRowData.stockQuantity!=null?activeRowData.stockQuantity:'');
        $('#editError').hide().text('');
        $('#editModal').addClass('active');
    });

    function closeEditModal(){ $('#editModal').removeClass('active'); $('#editSpinner').removeClass('active'); }
    $('#closeEditModal,#cancelEdit').on('click', closeEditModal);
    $('#editModal').on('click', function(e){ if($(e.target).is('#editModal')) closeEditModal(); });

    $('#saveEdit').on('click', function(){
        $('#editError').hide();
        const id      = $('#editId').val();
        const payload = {
            sku:           $('#editSku').val().trim(),
            name:          $('#editName').val().trim(),
            category:      $('#editCategory').val().trim(),
            currentPrice:  parseFloat($('#editPrice').val()),
            stockQuantity: parseInt($('#editStock').val())
        };
        if(!payload.name)                                        { $('#editError').text('Product name is required.').show(); return; }
        if(isNaN(payload.currentPrice)||payload.currentPrice<0)  { $('#editError').text('Enter a valid price.').show(); return; }
        if(isNaN(payload.stockQuantity)||payload.stockQuantity<0){ $('#editError').text('Enter a valid stock quantity.').show(); return; }

        $.ajax({
            url:'/api/product-update/'+id, type:'PUT', contentType:'application/json',
            data: JSON.stringify(payload),
            success: function(res){ closeEditModal(); table.ajax.reload(null,false); showToast(res.message||'Product updated successfully!','success'); },
            error: function(xhr){
                let msg='Update failed.';
                try { const e=JSON.parse(xhr.responseText); msg=e.message||e.error||msg; } catch(_){}
                $('#editError').text(msg).show();
            }
        });
    });

    $(document).on('click', '.delete-option', function(e){
        e.stopPropagation(); $('#actionMenu').hide();
        if(!activeRowData){ showToast('No row selected','error'); return; }
        pendingDeleteId   = parseInt(activeRowData.id);
        pendingDeleteName = activeRowData.name||'this product';
        if(isNaN(pendingDeleteId)){ showToast('Could not resolve product ID','error'); return; }
        $('#confirm-msg').text('Are you sure you want to delete "'+pendingDeleteName+'"? This cannot be undone.');
        $('#confirm-overlay').addClass('active');
    });

    $('#confirmNo').on('click', () => { $('#confirm-overlay').removeClass('active'); pendingDeleteId=null; });
    $('#confirm-overlay').on('click', function(e){ if($(e.target).is('#confirm-overlay')){ $('#confirm-overlay').removeClass('active'); pendingDeleteId=null; } });

    $('#confirmYes').on('click', function(){
        $('#confirm-overlay').removeClass('active');
        if(!pendingDeleteId) return;
        const id=pendingDeleteId; pendingDeleteId=null;
        $.ajax({
            url:'/api/product-delete/'+id, type:'DELETE',
            success: function(res){ activeRowData=null; table.ajax.reload(null,false); showToast(res.message||'Product deleted!','success'); },
            error:   function(xhr){
                let msg='Delete failed.';
                try { const e=JSON.parse(xhr.responseText); msg=e.message||e.error||msg; } catch(_){}
                showToast(msg,'error');
            }
        });
    });

});
</script>
</body>
</html>
