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

/**
 * ==========================================================================
 * AI COURSE ADVISOR & RECOMMENDATION ENGINE
 * Provides real-time matching via Jakarta Servlet with client fallback
 * ==========================================================================
 */
window.runAiCourseAdvisor = function () {
    const careerGoal = document.getElementById('aiCareerGoal')?.value || 'Full Stack Web Developer';
    const skillLevel = document.getElementById('aiSkillLevel')?.value || 'Intermediate';
    const primaryInterest = document.getElementById('aiPrimaryInterest')?.value || 'Java & Web';
    const weeklyHours = document.getElementById('aiWeeklyHours')?.value || '6-12';
    const learningStyle = document.getElementById('aiLearningStyle')?.value || 'Hands-on Projects';

    const btn = document.getElementById('btnRunAiAdvisor');
    const btnText = document.getElementById('btnRunAiAdvisorText');
    const originalText = btnText ? btnText.textContent : 'Generate AI Blueprint';

    if (btn) {
        btn.disabled = true;
        btn.style.opacity = '0.75';
    }
    if (btnText) {
        btnText.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Neural Matching...';
    }

    // Determine Servlet endpoint URL
    let contextPath = '';
    const path = window.location.pathname;
    if (path.includes('/user/')) {
        contextPath = path.substring(0, path.indexOf('/user/'));
    } else if (path.includes('/CAPACITY-CONNECT')) {
        contextPath = '/CAPACITY-CONNECT';
    }

    const servletUrl = (contextPath ? contextPath : '') + '/AICourseAdvisorServlet' +
        '?careerGoal=' + encodeURIComponent(careerGoal) +
        '&skillLevel=' + encodeURIComponent(skillLevel) +
        '&primaryInterest=' + encodeURIComponent(primaryInterest) +
        '&weeklyHours=' + encodeURIComponent(weeklyHours) +
        '&learningStyle=' + encodeURIComponent(learningStyle);

    // Call backend Servlet with fallback simulation
    fetch(servletUrl)
        .then(res => {
            if (!res.ok) throw new Error('Servlet returned ' + res.status);
            return res.json();
        })
        .then(data => {
            renderAiRecommendation(data);
            finishAiButton(btn, btnText, originalText);
        })
        .catch(err => {
            console.log('Servlet unreachable, using local AI matching engine:', err.message);
            // Local intelligent rule-engine fallback
            const localData = computeLocalAiRecommendation(careerGoal, skillLevel, primaryInterest, weeklyHours, learningStyle);
            setTimeout(() => {
                renderAiRecommendation(localData);
                finishAiButton(btn, btnText, originalText);
            }, 350);
        });
};

function finishAiButton(btn, btnText, originalText) {
    if (btn) {
        btn.disabled = false;
        btn.style.opacity = '1';
    }
    if (btnText) {
        btnText.textContent = originalText;
    }
}

function renderAiRecommendation(data) {
    const resultsWrapper = document.getElementById('aiResultsWrapper');
    if (!resultsWrapper) return;

    // 1. Top Course Hero
    const scoreText = document.getElementById('aiMatchScoreText');
    const heroTitle = document.getElementById('aiHeroCourseTitle');
    const heroCategory = document.getElementById('aiHeroCourseCategory');
    const heroLevel = document.getElementById('aiHeroCourseLevel');
    const heroDuration = document.getElementById('aiHeroCourseDuration');
    const heroDesc = document.getElementById('aiHeroCourseDesc');
    const reasoningText = document.getElementById('aiReasoningText');

    if (scoreText && data.topCourse) scoreText.textContent = data.topCourse.matchPercent + '% Recommendation Match';
    if (heroTitle && data.topCourse) heroTitle.textContent = data.topCourse.title;
    if (heroCategory && data.topCourse) heroCategory.textContent = data.topCourse.category;
    if (heroLevel && data.topCourse) heroLevel.textContent = data.topCourse.level;
    if (heroDuration && data.topCourse) heroDuration.textContent = data.topCourse.duration;
    if (heroDesc && data.topCourse) heroDesc.textContent = data.topCourse.description;
    if (reasoningText) reasoningText.textContent = data.aiReasoning;

    // 2. 3-Phase Milestone Roadmap
    const roadmapContainer = document.getElementById('aiRoadmapStepsList');
    if (roadmapContainer && data.roadmap && data.roadmap.length > 0) {
        roadmapContainer.innerHTML = data.roadmap.map((step, idx) => `
            <div class="ai-roadmap-step-item">
                <span class="ai-step-dot">${idx + 1}</span>
                <span>${step}</span>
            </div>
        `).join('');
    }

    // 3. Pathway Elective Courses Grid
    const pathwayContainer = document.getElementById('aiPathwayCoursesGrid');
    if (pathwayContainer && data.pathwayCourses) {
        pathwayContainer.innerHTML = data.pathwayCourses.map(c => `
            <div class="ai-pathway-mini-card">
                <div>
                    <span style="font-size: 10.5px; font-weight: 700; color: #FF385C; text-transform: uppercase;">${c.category} &bull; ${c.level}</span>
                    <h5 style="font-size: 13.5px; font-weight: 700; color: #0F172A; margin: 4px 0 2px 0;">${c.title}</h5>
                    <span style="font-size: 11px; color: #64748B;">Compatibility Score: <strong style="color: #059669;">${c.matchPercent}%</strong></span>
                </div>
                <a href="course-learning.jsp" class="panel-header-link" style="white-space: nowrap; font-size: 12px; font-weight: 700;">
                    Start &rarr;
                </a>
            </div>
        `).join('');
    }

    // Reveal results with smooth animation
    resultsWrapper.classList.add('active');
    resultsWrapper.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

/**
 * Intelligent Client-Side Multi-Dimensional Scoring Engine
 * (Exact parity with AICourseAdvisorServlet)
 */
function computeLocalAiRecommendation(careerGoal, skillLevel, primaryInterest, weeklyHours, learningStyle) {
    const catalog = [
        {
            id: 1,
            title: "Java Programming for Beginners",
            category: "Programming",
            level: "Beginner",
            duration: "12 Weeks",
            description: "Master Java from syntax to OOP, collections, multithreading, and real-world system architecture."
        },
        {
            id: 2,
            title: "React JS & Modern Web Development",
            category: "Web Development",
            level: "Intermediate",
            duration: "8 Weeks",
            description: "Build high-performance client applications using React 18, Hooks, state management, and Tailwind CSS."
        },
        {
            id: 3,
            title: "Python Basics & Algorithmic Thinking",
            category: "Programming",
            level: "Beginner",
            duration: "6 Weeks",
            description: "Hands-on Python course covering data structures, algorithmic puzzles, APIs, and practical scripting."
        },
        {
            id: 4,
            title: "Artificial Intelligence & Machine Learning",
            category: "AI & ML",
            level: "Advanced",
            duration: "14 Weeks",
            description: "Comprehensive machine learning curriculum from regression and classification to neural networks and LLMs."
        },
        {
            id: 5,
            title: "Cloud Computing & DevOps Engineering",
            category: "Cloud",
            level: "Intermediate",
            duration: "10 Weeks",
            description: "Containerization with Docker, Kubernetes clustering, CI/CD pipelines, and AWS cloud deployment."
        },
        {
            id: 6,
            title: "Full Stack Web Development Bootcamp",
            category: "Full Stack",
            level: "Intermediate",
            duration: "16 Weeks",
            description: "End-to-end full stack mastery covering Frontend, Backend REST APIs, SQL databases, and cloud hosting."
        },
        {
            id: 7,
            title: "Database Systems & SQL Optimization",
            category: "Database",
            level: "Beginner",
            duration: "6 Weeks",
            description: "Relational database design, ACID compliance, query optimization, indexing, and enterprise schema tuning."
        }
    ];

    const goalNorm = careerGoal.toLowerCase();
    const interestNorm = primaryInterest.toLowerCase();
    const levelNorm = skillLevel.toLowerCase();

    const scored = catalog.map(c => {
        let score = 50;
        const title = c.title.toLowerCase();
        const cat = c.category.toLowerCase();
        const lvl = c.level.toLowerCase();

        // Goal matching
        if (goalNorm.includes("full stack") && (cat.includes("full stack") || cat.includes("web") || title.includes("java"))) score += 32;
        if (goalNorm.includes("ai") || goalNorm.includes("machine learning")) {
            if (cat.includes("ai") || title.includes("python") || title.includes("intelligence")) score += 35;
        }
        if (goalNorm.includes("cloud") || goalNorm.includes("devops")) {
            if (cat.includes("cloud") || title.includes("cloud") || title.includes("devops")) score += 35;
        }
        if (goalNorm.includes("data")) {
            if (title.includes("python") || title.includes("database") || cat.includes("ai")) score += 30;
        }

        // Tech interest matching
        if (interestNorm.includes("java") && (title.includes("java") || cat.includes("programming"))) score += 20;
        if (interestNorm.includes("python") && (title.includes("python") || cat.includes("ai"))) score += 20;
        if (interestNorm.includes("react") && (title.includes("react") || cat.includes("web"))) score += 20;
        if (interestNorm.includes("cloud") && (title.includes("cloud") || cat.includes("cloud"))) score += 20;
        if (interestNorm.includes("database") && (title.includes("database") || cat.includes("database"))) score += 20;

        // Skill level matching
        if (levelNorm.includes("beginner") && lvl.includes("beginner")) score += 12;
        else if (levelNorm.includes("intermediate") && lvl.includes("intermediate")) score += 12;
        else if (levelNorm.includes("advanced") && (lvl.includes("advanced") || lvl.includes("intermediate"))) score += 12;

        let matchPercent = Math.min(99, Math.max(68, score));
        return { ...c, matchPercent };
    });

    // Sort descending
    scored.sort((a, b) => b.matchPercent - a.matchPercent);

    const topCourse = scored[0];
    const pathwayCourses = scored.slice(1, 3);

    // AI Reasoning
    let aiReasoning = `Based on your goal to excel as a ${careerGoal} with ${skillLevel} proficiency, our AI matched "${topCourse.title}" as your highest-yield foundation (compatible with ${weeklyHours} hrs/week commitment via ${learningStyle}).`;

    // 3-Phase Roadmap
    const roadmap = [
        `Phase 1: Core Fundamentals (${topCourse.title.split(' ')[0]} Syntax, Algorithms & Memory Model)`,
        `Phase 2: Architectural Patterns, MVC Frameworks & Production Database Integration`,
        `Phase 3: Portfolio Capstone, Automated Testing & Placement Interview Preparation`
    ];

    return {
        targetCareer: careerGoal,
        skillLevel: skillLevel,
        weeklyHours: weeklyHours,
        aiReasoning: aiReasoning,
        topCourse: topCourse,
        roadmap: roadmap,
        pathwayCourses: pathwayCourses
    };
}

// Auto-run recommendation once DOM is ready so cards are pre-filled
document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('aiAdvisorForm')) {
        setTimeout(() => {
            window.runAiCourseAdvisor();
        }, 150);
    }
});
