/**
 * ==========================================================================
 * CAPACITY CONNECT - STUDENT DASHBOARD INTERACTION CONTROLLER
 * Matching the exact coral-pink aesthetic, animations & responsive controls
 * ==========================================================================
 */

document.addEventListener('DOMContentLoaded', () => {
    // 1. Mobile Sidebar Drawer Toggle
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

    // 2. Fullscreen Toggle Button
    const fullscreenBtn = document.getElementById('fullscreenToggleBtn');
    if (fullscreenBtn) {
        fullscreenBtn.addEventListener('click', () => {
            if (!document.fullscreenElement) {
                document.documentElement.requestFullscreen().catch(err => {
                    console.log('Error attempting to enable fullscreen:', err.message);
                });
            } else {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                }
            }
        });
    }

    // 3. Search Courses / Resources Live Filter
    const searchInput = document.getElementById('dashboardSearchInput');
    if (searchInput) {
        searchInput.addEventListener('input', () => {
            const query = searchInput.value.toLowerCase().trim();
            const courseCards = document.querySelectorAll('.course-mini-card');
            const resourceItems = document.querySelectorAll('.resource-compact-item');

            courseCards.forEach(card => {
                const title = (card.querySelector('.course-mini-title')?.textContent || '').toLowerCase();
                if (title.includes(query) || !query) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });

            resourceItems.forEach(item => {
                const name = (item.querySelector('.resource-compact-name')?.textContent || '').toLowerCase();
                if (name.includes(query) || !query) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    }

    // 4. Notification Bell Quick Dropdown / Toast
    const notifBtn = document.getElementById('notifBellBtn');
    if (notifBtn) {
        notifBtn.addEventListener('click', (e) => {
            e.preventDefault();
            alert('Notifications (3 New):\n1. Data Structures Class starts today at 6:00 PM\n2. Java Project Assignment deadline is Nov 10\n3. New study notes for Web Development published');
        });
    }

    // 5. Submit Doubt Form Handler
    const submitDoubtBtn = document.getElementById('btnSubmitDoubt');
    const doubtTextarea = document.getElementById('doubtTextarea');
    if (submitDoubtBtn && doubtTextarea) {
        submitDoubtBtn.addEventListener('click', () => {
            const val = doubtTextarea.value.trim();
            if (!val) {
                alert('Please type your doubt or question before submitting.');
                doubtTextarea.focus();
                return;
            }
            alert('Your doubt has been submitted successfully! The course instructor will respond shortly.');
            doubtTextarea.value = '';
        });
    }

    // 6. Video Preview Player Launcher
    const videoWrapper = document.getElementById('continueVideoWrapper');
    const videoModal = document.getElementById('videoModalOverlay');
    const modalVideoPlayer = document.getElementById('modalVideoPlayer');

    if (videoWrapper && videoModal) {
        videoWrapper.addEventListener('click', () => {
            videoModal.classList.add('active');
            if (modalVideoPlayer) {
                modalVideoPlayer.play().catch(() => {});
            }
        });
    }

    window.closeVideoModal = function() {
        if (videoModal) {
            videoModal.classList.remove('active');
            if (modalVideoPlayer) {
                modalVideoPlayer.pause();
                modalVideoPlayer.currentTime = 0;
            }
        }
    };

    // 7. Modals Keyboard & Backdrop Close
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeAllDashboardModals();
        }
    });

    ['submitModalOverlay', 'progressModalOverlay', 'certModalOverlay', 'videoModalOverlay'].forEach(id => {
        const overlay = document.getElementById(id);
        if (overlay) {
            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) {
                    closeAllDashboardModals();
                }
            });
        }
    });
});

function closeAllDashboardModals() {
    document.querySelectorAll('.modal-overlay').forEach(m => m.classList.remove('active'));
    const modalVideoPlayer = document.getElementById('modalVideoPlayer');
    if (modalVideoPlayer) {
        modalVideoPlayer.pause();
    }
}

// Assignment Submission Modal Handler
window.openSubmitModal = function (id, title, courseTitle) {
    const aId = document.getElementById('modalAssignmentId');
    const aTitle = document.getElementById('modalAssignmentTitle');
    const overlay = document.getElementById('submitModalOverlay');

    if (aId) aId.value = id;
    if (aTitle) aTitle.value = (courseTitle ? courseTitle + " - " : "") + title;
    if (overlay) overlay.classList.add('active');
};

window.closeSubmitModal = function () {
    const overlay = document.getElementById('submitModalOverlay');
    if (overlay) overlay.classList.remove('active');
};

// Progress Update Modal Handler
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

// Quick Schedule Join Feedback
window.joinSession = function (sessionTitle) {
    alert('Connecting to live lecture room for: ' + sessionTitle);
};

window.viewSession = function (sessionTitle) {
    alert('Session details for: ' + sessionTitle);
};
