/**
 * ==========================================================================
 * CAPACITY CONNECT - STUDENT DASHBOARD CLIENT INTERACTION CONTROLLER
 * ==========================================================================
 */

document.addEventListener('DOMContentLoaded', () => {
    // Mobile Sidebar Toggle
    const mobileBtn = document.getElementById('mobileMenuBtn');
    const sidebar = document.getElementById('studentSidebar');
    const backdrop = document.getElementById('sidebarBackdrop');

    if (mobileBtn && sidebar && backdrop) {
        mobileBtn.addEventListener('click', () => {
            sidebar.classList.toggle('open');
            backdrop.classList.toggle('active');
        });

        backdrop.addEventListener('click', () => {
            sidebar.classList.remove('open');
            backdrop.classList.remove('active');
        });
    }

    // Live Course Filter
    const searchInput = document.getElementById('courseSearchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', () => {
            const query = searchInput.value.toLowerCase().trim();
            const cards = document.querySelectorAll('.course-card');
            cards.forEach(card => {
                const title = card.getAttribute('data-course-title') || '';
                if (title.includes(query)) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    }

    // Notification Trigger Alert
    const notifBtn = document.getElementById('notifBellBtn');
    if (notifBtn) {
        notifBtn.addEventListener('click', () => {
            alert('Notifications:\n- Graded: Servlet Authentication & Session Management (95/100)\n- Reminder: AI Neural Networks Assignment due soon.\n- Attendance: Marked PRESENT for recent lectures.');
        });
    }

    // Close Modals on Escape Key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeAllModals();
        }
    });

    // Close Modals on Backdrop Click
    ['submitModalOverlay', 'progressModalOverlay', 'certModalOverlay'].forEach(id => {
        const overlay = document.getElementById(id);
        if (overlay) {
            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) {
                    overlay.classList.remove('active');
                }
            });
        }
    });
});

// Modal Control Functions
window.openSubmitModal = function (id, title, courseTitle) {
    const aId = document.getElementById('modalAssignmentId');
    const aTitle = document.getElementById('modalAssignmentTitle');
    const overlay = document.getElementById('submitModalOverlay');

    if (aId) aId.value = id;
    if (aTitle) aTitle.value = courseTitle + " - " + title;
    if (overlay) overlay.classList.add('active');
};

window.closeSubmitModal = function () {
    const overlay = document.getElementById('submitModalOverlay');
    if (overlay) overlay.classList.remove('active');
};

window.openProgressModal = function (courseId, title, currentProgress) {
    const cId = document.getElementById('modalCourseId');
    const cTitle = document.getElementById('modalCourseTitle');
    const range = document.getElementById('progressRange');
    const display = document.getElementById('progressDisplayVal');
    const overlay = document.getElementById('progressModalOverlay');

    if (cId) cId.value = courseId;
    if (cTitle) cTitle.value = title;
    if (range) range.value = currentProgress;
    if (display) display.innerText = currentProgress;
    if (overlay) overlay.classList.add('active');
};

window.closeProgressModal = function () {
    const overlay = document.getElementById('progressModalOverlay');
    if (overlay) overlay.classList.remove('active');
};

window.openCertModal = function (certId, courseTitle, studentName, issueDate) {
    const sName = document.getElementById('certModalStudent') || document.getElementById('certModalStudentName');
    const cTitle = document.getElementById('certModalCourse') || document.getElementById('certModalCourseTitle');
    const id = document.getElementById('certModalId');
    const date = document.getElementById('certModalDate');
    const overlay = document.getElementById('certModalOverlay');

    if (sName && studentName) sName.innerText = studentName;
    if (cTitle && courseTitle) cTitle.innerText = courseTitle;
    if (id && certId) id.innerText = certId;
    if (date && issueDate) date.innerText = issueDate;
    if (overlay) overlay.classList.add('active');
};

window.closeCertModal = function () {
    const overlay = document.getElementById('certModalOverlay');
    if (overlay) overlay.classList.remove('active');
};

function closeAllModals() {
    window.closeSubmitModal();
    window.closeProgressModal();
    window.closeCertModal();
}
