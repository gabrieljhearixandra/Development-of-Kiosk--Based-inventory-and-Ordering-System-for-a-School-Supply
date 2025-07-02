// Support modal functionality
function showEditModal(id, question, answer) {
    const modal = document.getElementById('editSupportModal');
    document.getElementById('edit_support_id').value = id;
    document.getElementById('edit_question').value = question;
    document.getElementById('edit_answer').value = answer;
    modal.classList.remove('hidden');
}

function hideEditModal() {
    document.getElementById('editSupportModal').classList.add('hidden');
}

// Close modal when clicking outside or pressing Escape
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('editSupportModal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === this) hideEditModal();
        });
    }

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && modal && !modal.classList.contains('hidden')) {
            hideEditModal();
        }
    });
});