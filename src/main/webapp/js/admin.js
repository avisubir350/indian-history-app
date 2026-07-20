/* ============================================================
   Bharata Katha — Admin JavaScript
   ============================================================ */

// ── Table Search/Filter ───────────────────────────────────────
function filterTable() {
    const input  = document.getElementById('tableSearch');
    const table  = document.getElementById('storiesTable');
    if (!input || !table) return;
    const filter = input.value.toLowerCase();
    const rows   = table.getElementsByTagName('tr');
    for (let i = 1; i < rows.length; i++) {
        const text = rows[i].textContent.toLowerCase();
        rows[i].style.display = text.includes(filter) ? '' : 'none';
    }
}

function filterUsers() {
    const input = document.getElementById('userSearch');
    const table = document.getElementById('usersTable');
    if (!input || !table) return;
    const filter = input.value.toLowerCase();
    const rows   = table.getElementsByTagName('tr');
    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display = rows[i].textContent.toLowerCase().includes(filter) ? '' : 'none';
    }
}

// ── Topic Form Fill (edit mode) ───────────────────────────────
function fillTopicForm(id, name, desc, icon, color) {
    document.getElementById('topicId').value   = id;
    document.getElementById('topicName').value = name;
    document.getElementById('topicDesc').value = desc || '';
    document.getElementById('topicIcon').value = icon || '';
    document.getElementById('topicColor').value = color || '#C8860A';
    const title = document.getElementById('topicFormTitle');
    if (title) title.innerHTML = '<i class="fas fa-pen-to-square"></i> Edit Topic: ' + name;
    document.querySelector('.admin-form-card').scrollIntoView({ behavior: 'smooth' });
}

function resetTopicForm() {
    document.getElementById('topicId').value = '';
    document.getElementById('topicName').value = '';
    document.getElementById('topicDesc').value = '';
    document.getElementById('topicIcon').value = '';
    document.getElementById('topicColor').value = '#C8860A';
    const title = document.getElementById('topicFormTitle');
    if (title) title.innerHTML = '<i class="fas fa-plus-circle"></i> Add Topic';
}

// ── Auto-dismiss flash messages ───────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(el => {
        setTimeout(() => {
            el.style.transition = 'opacity .5s';
            el.style.opacity = '0';
            setTimeout(() => el.remove(), 500);
        }, 4000);
    });
});
