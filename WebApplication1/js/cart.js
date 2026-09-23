/**
 * NEXUS PLAY - Client-Side Cart & Toast Utility
 * Works seamlessly with ASP.NET Server-Side SQL Server persistence.
 */
(function (window) {
    const NexusCart = {
        showToast: function (title, message) {
            let container = document.getElementById('nexus-toast-container');
            if (!container) {
                container = document.createElement('div');
                container.id = 'nexus-toast-container';
                container.className = 'nexus-toast-container';
                document.body.appendChild(container);
            }

            const toast = document.createElement('div');
            toast.className = 'nexus-toast';
            toast.innerHTML = `
                <div class="toast-icon">
                    <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
                        <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                    </svg>
                </div>
                <div class="toast-content">
                    <div class="toast-title">${title}</div>
                    <div class="toast-msg">${message}</div>
                </div>
            `;

            container.appendChild(toast);
            setTimeout(function () {
                toast.classList.add('show');
            }, 10);

            setTimeout(function () {
                toast.classList.remove('show');
                setTimeout(function () {
                    if (toast.parentNode) {
                        toast.parentNode.removeChild(toast);
                    }
                }, 300);
            }, 3200);
        }
    };

    window.NexusCart = NexusCart;
})(window);
