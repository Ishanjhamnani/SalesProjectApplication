(function () {

    // ── Clean up any corrupted token values ───────────────────────────────
    // Handles cases where "undefined" or "null" was stored as a string
    (function cleanStorage() {
        var bad = ['undefined', 'null', '', 'false'];
        ['token', 'refreshToken'].forEach(function (key) {
            var val = localStorage.getItem(key);
            if (val === null || bad.indexOf(val) !== -1) {
                localStorage.removeItem(key);
            }
        });
    })();

    // ── Helper: is the user genuinely logged in? ──────────────────────────
    function hasValidToken() {
        var token = localStorage.getItem('token');
        return token !== null && token !== undefined && token.trim() !== '';
    }

    // ── Protected paths — redirect to login if no token ───────────────────
    var PROTECTED_PATHS = [
        '/pages/customers',
        '/pages/products',
        '/pages/orders',
        '/pages/place-order',
        '/pages/dashboard'
    ];

    var currentPath = window.location.pathname;

    if (PROTECTED_PATHS.indexOf(currentPath) !== -1 && !hasValidToken()) {
        window.location.href = '/pages/login';
    }

    // ── Attach JWT to every jQuery AJAX request ───────────────────────────
    $.ajaxSetup({
        beforeSend: function (xhr) {
            var token = localStorage.getItem('token');
            if (token) {
                xhr.setRequestHeader('Authorization', 'Bearer ' + token);
            }
        }
    });

    // ── Handle 401 globally (access token expired) ────────────────────────
    $(document).ajaxError(function (event, xhr, settings) {
        if (settings.url === '/auth/refresh') return;

        if (xhr.status === 401) {
            var refreshToken = localStorage.getItem('refreshToken');
            if (!refreshToken) { Auth.logout(); return; }

            $.ajax({
                url:         '/auth/refresh',
                type:        'POST',
                contentType: 'application/json',
                data:        JSON.stringify({ refreshToken: refreshToken }),
                success: function (res) {
                    if (res.accessToken) {
                        localStorage.setItem('token', res.accessToken);
                        location.reload();
                    } else {
                        Auth.logout();
                    }
                },
                error: function () {
                    Auth.logout();
                }
            });
        }
    });

    // ── Global Auth helpers ───────────────────────────────────────────────
    window.Auth = {

        getToken: function () {
            return localStorage.getItem('token');
        },

        setToken: function (token) {
            localStorage.setItem('token', token);
        },

        clearToken: function () {
            localStorage.removeItem('token');
        },

        isLoggedIn: function () {
            return hasValidToken();
        },

        logout: function () {
            localStorage.removeItem('token');
            localStorage.removeItem('refreshToken');
            window.location.href = '/pages/login';
        }
    };

})();
