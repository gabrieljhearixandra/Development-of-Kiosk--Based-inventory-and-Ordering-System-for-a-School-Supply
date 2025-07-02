function toggleAnswer(questionElement) {
    // Close all other open answers first
    document.querySelectorAll('.faq-answer.show').forEach(answer => {
        if (answer !== questionElement.nextElementSibling) {
            answer.classList.remove('show');
            answer.previousElementSibling.querySelector('i').style.transform = 'rotate(0)';
        }
    });
    
    // Toggle current answer
    const answer = questionElement.nextElementSibling;
    const icon = questionElement.querySelector('i');
    answer.classList.toggle('show');
    icon.style.transform = answer.classList.contains('show') 
        ? 'rotate(180deg)' 
        : 'rotate(0)';
}

function searchFAQs() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const faqItems = document.querySelectorAll('.faq-item');
    let hasResults = false;

    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question span').textContent.toLowerCase();
        const answer = item.querySelector('.faq-answer').textContent.toLowerCase();
        
        if (question.includes(searchTerm) || answer.includes(searchTerm)) {
            item.classList.remove('hidden');
            hasResults = true;
        } else {
            item.classList.add('hidden');
        }
    });

    const noResults = document.querySelector('.no-faqs');
    if (!hasResults && searchTerm) {
        if (!noResults) {
            const faqList = document.querySelector('.faq-list');
            const message = document.createElement('div');
            message.className = 'no-faqs';
            message.textContent = 'No results found for your search.';
            faqList.appendChild(message);
        } else {
            noResults.textContent = 'No results found for your search.';
            noResults.classList.remove('hidden');
        }
    } else if (noResults) {
        noResults.classList.add('hidden');
    }
}

// Add keyboard accessibility
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.faq-question').forEach(question => {
        question.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                toggleAnswer(this);
            }
        });
    });

    // Add event listener for search input
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', searchFAQs);
    }
}); 