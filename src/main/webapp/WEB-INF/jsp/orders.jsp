<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Orders — SalesPanel</title>
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
    --red:#dc2626; --red-soft:#fff1f1;
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
    --red:#dc2626; --red-soft:#fff1f1;
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

/* Action Button */
.action-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    background: var(--surface);
    border: 1.5px solid var(--border-2);
    border-radius: var(--radius-sm);
    color: var(--text-dim);
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.15s ease;
}
.action-btn:hover {
    background: var(--blue-soft);
    color: var(--blue);
    border-color: rgba(37, 99, 235, 0.3);
}
.action-btn:active {
    transform: translateY(1px);
}

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
/* Status badges */
.badge{display:inline-flex;align-items:center;gap:5px;padding:4px 10px;border-radius:999px;font-family:'JetBrains Mono',monospace;font-size:10px;font-weight:600;letter-spacing:0.06em;text-transform:uppercase;}
.badge::before{content:'';width:5px;height:5px;border-radius:50%;flex-shrink:0;}
.badge-PLACED{background:rgba(217,119,6,0.10);color:#d97706;border:1.5px solid rgba(217,119,6,0.2);}
.badge-PLACED::before{background:#d97706;}
.badge-PROCESSING{background:var(--blue-soft);color:var(--blue);border:1.5px solid rgba(37,99,235,0.2);}
.badge-PROCESSING::before{background:var(--blue);}
.badge-COMPLETED{background:var(--green-soft);color:var(--green);border:1.5px solid rgba(22,163,74,0.2);}
.badge-COMPLETED::before{background:var(--green);}
.badge-CANCELLED{background:var(--red-soft);color:var(--red);border:1.5px solid rgba(220,38,38,0.2);}
.badge-CANCELLED::before{background:var(--red);}
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
/* Order Modal */
#orderModal{display:none;position:fixed;inset:0;background:rgba(15,23,42,0.55);z-index:10000;align-items:center;justify-content:center;backdrop-filter:blur(6px);}
#orderModal.active{display:flex;}
#orderModal .modal-content{background:#ffffff !important;border:1px solid rgba(99,115,155,0.18);color:#0f172a !important;border-radius:16px;padding:32px;width:540px;max-width:95vw;position:relative;max-height:90vh;overflow-y:auto;animation:popIn 0.2s cubic-bezier(0.34,1.56,0.64,1);box-shadow:0 24px 80px rgba(15,23,42,0.16);}
@keyframes popIn{from{transform:scale(0.9);opacity:0;}to{transform:scale(1);opacity:1;}}
#orderModal .modal-content::-webkit-scrollbar{width:4px;}
#orderModal .modal-content::-webkit-scrollbar-thumb{background:var(--border-2);border-radius:2px;}
#orderModal h3{margin:0 0 24px 0;font-size:18px;font-weight:800;letter-spacing:-0.02em;color:var(--text);border-bottom:1px solid var(--border);padding-bottom:14px;}
#orderModal label{display:block !important;font-family:'JetBrains Mono',monospace !important;font-size:11px !important;font-weight:600 !important;color:#64748b !important;margin-bottom:6px !important;margin-top:10px !important;text-transform:uppercase !important;letter-spacing:0.08em !important;}
#orderModal input[type="text"],#orderModal input[type="number"]{width:100%;padding:10px 13px;border-radius:var(--radius-sm);border:1.5px solid #cbd5e1 !important;font-size:13.5px;color:#0f172a !important;background:#f8faff !important;font-family:'Plus Jakarta Sans',sans-serif;transition:border-color 0.15s,box-shadow 0.15s;outline:none;margin-bottom:4px;}
#orderModal input::placeholder{color:#94a3b8 !important;}
#orderModal input:focus{border-color:#2563eb !important;box-shadow:0 0 0 3px rgba(37,99,235,0.15) !important;}
.ac-wrap{position:relative;margin-bottom:16px;}
.ac-wrap input{margin-bottom:0;}
.ac-list{position:absolute;top:calc(100% + 4px);left:0;right:0;background:var(--surface);border:1.5px solid var(--border-2);border-radius:var(--radius-sm);max-height:200px;overflow-y:auto;z-index:999;display:none;box-shadow:var(--shadow-md);}
.ac-list .ac-item{padding:10px 13px;cursor:pointer;font-size:13px;color:var(--text-dim);border-bottom:1px solid var(--border);transition:background 0.1s;}
.ac-list .ac-item:last-child{border-bottom:none;}
.ac-list .ac-item:hover,.ac-list .ac-item.active{background:var(--blue-soft);color:var(--blue);}
.ac-list .ac-empty{padding:10px 13px;font-size:12px;color:var(--text-muted);font-family:'JetBrains Mono',monospace;}
.ac-selected-tag{display:none;align-items:center;gap:6px;background:var(--blue-soft);color:var(--blue);border:1.5px solid rgba(37,99,235,0.25);border-radius:999px;padding:4px 12px;font-size:12px;font-weight:700;margin-top:4px;margin-bottom:16px;font-family:'JetBrains Mono',monospace;}
.ac-selected-tag .ac-tag-remove{cursor:pointer;font-size:13px;color:rgba(37,99,235,0.4);}
.ac-selected-tag .ac-tag-remove:hover{color:var(--blue);}
.order-items-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;}
.order-items-header span{font-family:'JetBrains Mono',monospace;font-size:10px;font-weight:500;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.10em;}
#addItemBtn{padding:5px 12px;background:var(--surface-2);color:var(--text-dim);border:1.5px solid var(--border-2);border-radius:var(--radius-sm);cursor:pointer;font-family:'JetBrains Mono',monospace;font-size:11px;transition:all 0.15s;}
#addItemBtn:hover{background:var(--blue-soft);color:var(--blue);border-color:rgba(37,99,235,0.25);}
.item-col-headers{display:grid;grid-template-columns:1fr 80px 32px;gap:8px;margin-bottom:6px;}
.item-col-headers span{font-family:'JetBrains Mono',monospace;font-size:9px;font-weight:500;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.12em;}
.order-item-row{display:grid;grid-template-columns:1fr 80px 32px;gap:8px;align-items:start;margin-bottom:8px;}
.order-item-row .ac-wrap{margin-bottom:0;}
.order-item-row input[type="number"]{margin-bottom:0;}
.remove-item-btn{background:var(--red-soft);color:var(--red);border:1.5px solid rgba(220,38,38,0.2);border-radius:var(--radius-sm);cursor:pointer;font-size:13px;width:32px;height:40px;transition:all 0.15s;}
.remove-item-btn:hover{background:rgba(220,38,38,0.15);}
#orderSummary{background:var(--blue-soft);border:1.5px solid rgba(37,99,235,0.15);border-radius:var(--radius-sm);padding:14px 16px;margin:16px 0 20px 0;display:none;}
#orderSummary .summary-total{display:flex;justify-content:space-between;font-weight:800;font-size:15px;color:var(--text);}
#orderSummary .summary-total span:last-child{color:var(--blue);}
.modal-buttons{display:flex;gap:10px;margin-top:10px;}
#submitOrder{flex:1;padding:11px;background:linear-gradient(135deg,var(--blue),var(--indigo));color:white;border:none;border-radius:var(--radius-sm);cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;font-weight:700;transition:all 0.15s;box-shadow:0 4px 14px var(--blue-glow);}
#submitOrder:hover{transform:translateY(-1px);box-shadow:0 8px 22px rgba(37,99,235,0.28);}
#submitOrder:disabled{background:#c7d2fe;cursor:not-allowed;box-shadow:none;transform:none;}
#cancelOrder{flex:1;padding:11px;background:#f1f5f9 !important;color:#334155 !important;border:1.5px solid #cbd5e1 !important;border-radius:var(--radius-sm);cursor:pointer;font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;font-weight:700;transition:all 0.15s;}
#cancelOrder:hover{background:#e2e8f0 !important;}
#closeModal{position:absolute;top:18px;right:18px;background:var(--surface-2);border:1px solid var(--border-2);border-radius:7px;width:28px;height:28px;display:flex;align-items:center;justify-content:center;font-size:14px;cursor:pointer;color:var(--text-muted);transition:all 0.15s;}
#closeModal:hover{background:var(--bg);color:var(--text);}
.modal-error{background:var(--red-soft);color:var(--red);border:1.5px solid rgba(220,38,38,0.2);border-radius:var(--radius-sm);padding:10px 14px;font-size:12px;margin-bottom:16px;display:none;font-family:'JetBrains Mono',monospace;font-weight:500;}
</style>
</head>
<body>
<div id="toast-container"></div>
<div class="container">
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp"/>
    <div class="content">
        <div class="page-header">
            <div>
                <div class="page-eyebrow">Management</div>
                <div class="page-title">Orders</div>
                <div class="page-subtitle" id="orderCountLabel">Loading records…</div>
            </div>
            <button class="btn-primary" id="openOrderModal">+ Place an Order</button>
        </div>
        <div class="table-card">
            <table id="ordersTable" class="display" style="width:100%">
                <thead><tr>
                    <th>Sr No</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Total Amount</th>
                    <th>Customer</th>
                    <th>Actions</th>
                </tr></thead>
            </table>
        </div>
    </div>
</div>
<div id="orderModal">
    <div class="modal-content">
        <button id="closeModal" title="Close">✕</button>
        <h3>🛒 Place an Order</h3>
        <div class="modal-error" id="modalError"></div>
        <label>Customer</label>
        <div class="ac-wrap" id="customerWrap">
            <input type="text" id="customerSearch" placeholder="Type customer name…" autocomplete="off">
            <div class="ac-list" id="customerList"></div>
        </div>
        <div class="ac-selected-tag" id="customerTag">
            <span id="customerTagLabel"></span>
            <span class="ac-tag-remove" id="customerTagRemove">✕</span>
        </div>
        <input type="hidden" id="selectedCustomerId">
        <div class="order-items-header">
            <span>Products</span>
            <button id="addItemBtn" type="button">+ Add Product</button>
        </div>
        <div class="item-col-headers">
            <span>Product</span><span>Qty</span><span></span>
        </div>
        <div id="orderItemsContainer"></div>
        <div id="orderSummary">
            <div class="summary-total">
                <span>Estimated Total</span>
                <span id="summaryTotal">₹0.00</span>
            </div>
        </div>
        <div class="modal-buttons">
            <button id="submitOrder" type="button">Place Order</button>
            <button id="cancelOrder" type="button">Cancel</button>
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

// Function to handle secure PDF downloads
window.downloadInvoice = function(orderId) {
    const token = sessionStorage.getItem('token');

    // Optional: Show a loading toast
    showToast('Generating invoice...', 'info');

    fetch('/pages/reports/invoice/' + orderId, {
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + token
        }
    })
    .then(response => {
        if (!response.ok) throw new Error('Failed to generate invoice');
        return response.blob(); // Convert the response to a file blob
    })
    .then(blob => {
        // Create a hidden link to trigger the download
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'Invoice_' + orderId + '.pdf';
        document.body.appendChild(a);
        a.click();

        // Clean up
        a.remove();
        window.URL.revokeObjectURL(url);
        showToast('Invoice downloaded successfully!', 'success');
    })
    .catch(error => {
        console.error('Download error:', error);
        showToast('Error downloading invoice.', 'error');
    });
};

$(document).ready(function(){
    let allCustomers = [], allProducts = [], rowCounter = 0;

    const table = $('#ordersTable').DataTable({
        serverSide: true, processing: true,
        ajax: {
            url: '/orders/show-orders', type: 'GET',
            data: function(d) {
                return { draw:d.draw, start:d.start, length:d.length, search:d.search.value };
            },
            beforeSend: function(xhr) {
                var token = sessionStorage.getItem('token');
                if (token) xhr.setRequestHeader('Authorization', 'Bearer ' + token);
            },
            error: function(xhr){ console.error('Orders AJAX error:', xhr.status, xhr.responseText); }
        },
        columns: [
            { data:null, orderable:false, render:function(d,t,r,meta){
                return '<span style="font-family:\'JetBrains Mono\',monospace;font-size:11px;color:var(--text-muted)">'+(meta.settings._iDisplayStart+meta.row+1)+'</span>';
            }},
            { data:'orderDate', render:function(val){
                let str;
                if(Array.isArray(val)){
                    const [y,mo,d,h,mi]=val;
                    str=y+'-'+String(mo).padStart(2,'0')+'-'+String(d).padStart(2,'0')+' '+String(h).padStart(2,'0')+':'+String(mi).padStart(2,'0');
                } else { str=val||'—'; }
                return '<span style="font-family:\'JetBrains Mono\',monospace;font-size:11.5px">'+str+'</span>';
            }},
            { data:'status', render:function(s){ return '<span class="badge badge-'+s+'">'+s+'</span>'; }},
            { data:'totalAmount', render:function(v){
                return '<span style="font-weight:700;color:var(--text)">₹'+parseFloat(v||0).toFixed(2)+'</span>';
            }},
            { data:'customerName', render:function(d){
                return '<span style="font-weight:600;color:var(--text)">'+(d||'—')+'</span>';
            }},
            { data:'id', orderable:false, render:function(id){
                return '<button class="action-btn" onclick="downloadInvoice(' + id + ')">📄 Invoice</button>';
            }}
        ],
        dom: 'rtip',
        autoWidth: false,
        columnDefs: [
                     { width: '40px', targets: 0 }, // Strictly small for Sr No
                     { width: '18%',  targets: 1 }, // Date
                     { width: '12%',  targets: 2 }, // Status
                     { width: '15%',  targets: 3 }, // Total Amount
                     { width: '12%',  targets: 5 }  // Actions

                     // Notice how target 4 (Customer) is missing!
                     // It will now automatically stretch to fill the rest of the screen.
                 ],
        drawCallback: function(settings) {
            const total = settings.fnRecordsTotal();
            $('#orderCountLabel').text(total + ' total order' + (total !== 1 ? 's' : ''));
        }
    });

    function makeAutocomplete(cfg){
        let highlighted = -1;
        $(cfg.inputSel).on('input', function(){
            const q=$(this).val().trim().toLowerCase(); highlighted=-1;
            if(q.length<1){ $(cfg.listSel).hide().empty(); return; }
            const matches=cfg.data.filter(function(item){ return cfg.labelFn(item).toLowerCase().includes(q); }).slice(0,8);
            if(!matches.length){ $(cfg.listSel).html('<div class="ac-empty">No results found</div>').show(); return; }
            const html=matches.map(function(item,idx){ return '<div class="ac-item" data-idx="'+idx+'">'+cfg.labelFn(item)+'</div>'; }).join('');
            $(cfg.listSel).html(html).show();
            $(cfg.listSel).data('matches',matches);
        });
        $(document).on('click', cfg.listSel+' .ac-item', function(){
            const idx=$(this).data('idx');
            const matches=$(cfg.listSel).data('matches')||[];
            const item=matches[idx]; if(!item) return;
            $(cfg.inputSel).val(cfg.labelFn(item));
            $(cfg.listSel).hide().empty();
            cfg.onSelect(item);
        });
        $(cfg.inputSel).on('keydown', function(e){
            const items=$(cfg.listSel).find('.ac-item'); if(!items.length) return;
            if(e.key==='ArrowDown'){ e.preventDefault(); highlighted=Math.min(highlighted+1,items.length-1); }
            else if(e.key==='ArrowUp'){ e.preventDefault(); highlighted=Math.max(highlighted-1,0); }
            else if(e.key==='Enter'){ e.preventDefault(); if(highlighted>=0) items.eq(highlighted).trigger('click'); return; }
            else if(e.key==='Escape'){ $(cfg.listSel).hide().empty(); return; }
            items.removeClass('active').eq(highlighted).addClass('active');
        });
    }

    $(document).on('click', function(e){ if(!$(e.target).closest('.ac-wrap').length) $('.ac-list').hide(); });

    function initCustomerAC(){
        makeAutocomplete({
            inputSel:'#customerSearch', listSel:'#customerList',
            data:allCustomers, labelFn:function(c){ return c.firstName+' '+c.lastName; },
            onSelect:function(c){
                $('#selectedCustomerId').val(c.id);
                $('#customerSearch').hide();
                $('#customerTagLabel').text(c.firstName+' '+c.lastName);
                $('#customerTag').css('display','inline-flex');
                $('#modalError').hide();
            }
        });
    }

    $('#customerTagRemove').on('click', function(){
        $('#selectedCustomerId').val('');
        $('#customerSearch').val('').show().focus();
        $('#customerTag').hide();
    });

    function buildProductRow(){
        const rid='row-'+(++rowCounter);
        const row=$('<div class="order-item-row" data-rid="'+rid+'"></div>');
        const wrap=$('<div class="ac-wrap"></div>');
        wrap.append('<input type="text" class="product-search" id="ps-'+rid+'" placeholder="Type product…" autocomplete="off">');
        wrap.append('<div class="ac-list" id="pl-'+rid+'"></div>');
        wrap.append('<input type="hidden" class="selected-product-id" id="pid-'+rid+'">');
        wrap.append('<input type="hidden" class="selected-product-price" id="ppr-'+rid+'">');
        row.append(wrap);
        row.append('<input type="number" class="product-qty" min="1" value="1">');
        row.append('<button type="button" class="remove-item-btn" title="Remove">✕</button>');
        $('#orderItemsContainer').append(row);
        makeAutocomplete({
            inputSel:'#ps-'+rid, listSel:'#pl-'+rid,
            data:allProducts, labelFn:function(p){ return p.name; },
            onSelect:function(p){
                $('#pid-'+rid).val(p.id);
                $('#ppr-'+rid).val(p.currentPrice||0);
                $('#ps-'+rid).val(p.name+'  (₹'+parseFloat(p.currentPrice||0).toFixed(2)+')');
                recalcTotal();
            }
        });
        row.find('.product-qty').on('input change', recalcTotal);
    }

    function recalcTotal(){
        let total=0, hasItems=false;
        $('#orderItemsContainer .order-item-row').each(function(){
            const pid=$(this).find('.selected-product-id').val();
            const price=parseFloat($(this).find('.selected-product-price').val())||0;
            const qty=parseInt($(this).find('.product-qty').val())||0;
            if(pid&&qty>0){ total+=price*qty; hasItems=true; }
        });
        $('#summaryTotal').text('₹'+total.toFixed(2));
        hasItems?$('#orderSummary').show():$('#orderSummary').hide();
    }

    $(document).on('click', '.remove-item-btn', function(){
        if($('#orderItemsContainer .order-item-row').length===1){ showError('You need at least one product.'); return; }
        $(this).closest('.order-item-row').remove(); recalcTotal();
    });

    $('#addItemBtn').on('click', buildProductRow);

    $('#openOrderModal').on('click', function(){
        resetModal();
        const token=sessionStorage.getItem('token');
        const headers=token?{'Authorization':'Bearer '+token}:{};
        const custDone=$.ajax({ url:'/api/show-customers', type:'POST', data:{start:0,length:1000,draw:1,search:''}, headers:headers, success:function(res){ allCustomers=res.data||[]; } });
        const prodDone=$.ajax({ url:'/api/show-products',  type:'GET',  data:{start:0,length:1000,draw:1}, headers:headers, success:function(res){ allProducts=res.data||res||[]; } });
        $.when(custDone,prodDone).always(function(){ initCustomerAC(); buildProductRow(); $('#orderModal').addClass('active'); });
    });

    function closeModal(){ $('#orderModal').removeClass('active'); resetModal(); }
    $('#cancelOrder, #closeModal').on('click', closeModal);
    $('#orderModal').on('click', function(e){ if($(e.target).is('#orderModal')) closeModal(); });

    function resetModal(){
        $('#customerSearch').val('').show(); $('#customerTag').hide();
        $('#selectedCustomerId').val(''); $('#customerList').hide().empty();
        $('#orderItemsContainer').empty(); $('#orderSummary').hide();
        $('#modalError').hide().text('');
        $('#submitOrder').prop('disabled',false).text('Place Order');
        rowCounter=0;
    }

    $('#submitOrder').on('click', function(){
        $('#modalError').hide();
        const customerId=parseInt($('#selectedCustomerId').val());
        if(!customerId){ showError('Please select a customer.'); return; }
        const items=[]; let valid=true; const seen={};
        $('#orderItemsContainer .order-item-row').each(function(){
            const productId=parseInt($(this).find('.selected-product-id').val());
            const quantity=parseInt($(this).find('.product-qty').val());
            if(!productId){ showError('Please select a product for every row.'); valid=false; return false; }
            if(!quantity||quantity<1){ showError('Quantity must be at least 1.'); valid=false; return false; }
            if(seen[productId]){ showError('Duplicate product — combine quantities instead.'); valid=false; return false; }
            seen[productId]=true;
            items.push({productId:productId, quantity:quantity});
        });
        if(!valid) return;
        $('#submitOrder').prop('disabled',true).text('Placing…');
        const token=sessionStorage.getItem('token');
        $.ajax({
            url:'/orders/place', type:'POST', contentType:'application/json',
            beforeSend:function(xhr){ if(token) xhr.setRequestHeader('Authorization','Bearer '+token); },
            data:JSON.stringify({customerId:customerId, items:items}),
            success:function(res){ closeModal(); table.ajax.reload(null,false); showToast(res.message||'Order placed successfully!','success'); },
            error:function(xhr){
                let msg='Failed to place order.';
                try{ const e=JSON.parse(xhr.responseText); msg=e.message||e.error||msg; }catch(_){}
                showError(msg);
                $('#submitOrder').prop('disabled',false).text('Place Order');
            }
        });
    });

    function showError(msg){ $('#modalError').text(msg).show(); }
});
</script>
</body>
</html>