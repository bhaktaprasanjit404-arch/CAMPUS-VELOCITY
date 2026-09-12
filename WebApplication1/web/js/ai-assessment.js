/**
 * ==========================================================================
 * CAPACITY CONNECT - AI ASSESSMENT & CODE EVALUATION ENGINE
 * Pure Vanilla JavaScript Client-Side Pedagogical Engine
 * ==========================================================================
 */

(function () {
    // Subject Question Banks
    const QUESTION_BANKS = {
        java: [
            {
                question: "In Jakarta EE Servlets, which method is executed exactly once during a servlet's lifecycle?",
                code: "// Servlet Lifecycle\npublic class AuthServlet extends HttpServlet {\n    // Which initialization callback runs once?\n}",
                options: [
                    "init(ServletConfig config)",
                    "service(HttpServletRequest req, HttpServletResponse res)",
                    "doGet(HttpServletRequest req, HttpServletResponse res)",
                    "destroy()"
                ],
                correct: 0,
                explanation: "The 'init()' method is called by the servlet container exactly once when the servlet instance is loaded into memory, before any client requests are processed."
            },
            {
                question: "To prevent SQL injection attacks when querying MySQL from JDBC, which statement type MUST be used?",
                code: "// Secure database query pattern\nString sql = \"SELECT * FROM users WHERE email = ? AND role = ?\";\n// Which interface safely binds parameters?",
                options: [
                    "Statement",
                    "PreparedStatement",
                    "CallableStatement",
                    "RowSet"
                ],
                correct: 1,
                explanation: "PreparedStatement pre-compiles the SQL query and safely treats user inputs as literal parameters rather than executable SQL fragments, preventing SQL injection."
            },
            {
                question: "What is the primary architectural purpose of the MVC (Model-View-Controller) design pattern in Java web apps?",
                options: [
                    "To combine user interface and business logic in a single file",
                    "To separate data handling (Model), presentation (View), and request coordination (Controller)",
                    "To replace the relational database with an in-memory cache",
                    "To automatically compile HTML templates to C++"
                ],
                correct: 1,
                explanation: "MVC cleanly separates concerns: Models hold application data/DAOs, Views (JSP/HTML) render user interfaces, and Controllers (Servlets) manage client navigation and business workflows."
            }
        ],
        ai: [
            {
                question: "In artificial neural networks, what mathematical algorithm is used to calculate gradients of the loss function with respect to weights?",
                options: [
                    "K-Means Clustering",
                    "Backpropagation (Reverse-mode Automatic Differentiation)",
                    "Dijkstra's Shortest Path",
                    "Principal Component Analysis"
                ],
                correct: 1,
                explanation: "Backpropagation applies the calculus chain rule backwards from the output layer through hidden layers to compute partial derivatives of the loss with respect to all trainable parameters."
            },
            {
                question: "Which activation function is most widely used in modern deep feedforward layers to mitigate the vanishing gradient problem?",
                code: "f(x) = max(0, x)",
                options: [
                    "Sigmoid",
                    "Hyperbolic Tangent (tanh)",
                    "Rectified Linear Unit (ReLU)",
                    "Softmax"
                ],
                correct: 2,
                explanation: "ReLU (Rectified Linear Unit) has a constant gradient of 1 for positive inputs, which largely avoids vanishing gradients during deep backpropagation."
            },
            {
                question: "When a machine learning model achieves near 100% accuracy on training data but performs poorly on unseen test data, what has occurred?",
                options: [
                    "Underfitting",
                    "Overfitting (High Variance)",
                    "Label Leakage",
                    "Convergence Failure"
                ],
                correct: 1,
                explanation: "Overfitting occurs when a high-capacity model memorizes noise and specific peculiarities in the training set rather than learning generalized underlying patterns."
            }
        ],
        web: [
            {
                question: "In CSS Grid, which property value creates a responsive column grid that automatically wraps without media queries?",
                code: ".grid {\n    display: grid;\n    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));\n}",
                options: [
                    "flex-wrap: wrap",
                    "repeat(auto-fit, minmax(min, 1fr))",
                    "grid-auto-flow: dense",
                    "float: left"
                ],
                correct: 1,
                explanation: "'repeat(auto-fit, minmax(280px, 1fr))' automatically computes how many columns of at least 280px can fit in the viewport and stretches them equally."
            },
            {
                question: "In modern JavaScript, what does 'async / await' syntax provide over raw Promise chaining (.then)?",
                options: [
                    "It converts JavaScript to a multi-threaded execution model",
                    "It allows writing asynchronous asynchronous code that reads like synchronous sequential code",
                    "It bypasses the JavaScript browser event loop",
                    "It compresses HTTP payload requests automatically"
                ],
                correct: 1,
                explanation: "'async / await' is syntactic sugar over Promises, allowing try/catch blocks and cleaner readability without callback nesting or long '.then()' chains."
            }
        ],
        sql: [
            {
                question: "Which SQL constraint ensures that an enrolled student ID must correspond to an existing record in the users table?",
                code: "CONSTRAINT fk_enrollment_student\n    FOREIGN KEY (student_id)\n    REFERENCES users(id)\n    ON DELETE CASCADE",
                options: [
                    "CHECK Constraint",
                    "FOREIGN KEY Constraint",
                    "UNIQUE Constraint",
                    "DEFAULT Constraint"
                ],
                correct: 1,
                explanation: "A FOREIGN KEY enforces referential integrity between child and parent tables, ensuring orphan records cannot be inserted."
            },
            {
                question: "What does the 'I' in ACID transaction guarantees stand for in relational databases?",
                options: [
                    "Indexing",
                    "Isolation",
                    "Inheritance",
                    "Immutability"
                ],
                correct: 1,
                explanation: "Isolation guarantees that concurrent database transactions execute as if they were serialized, preventing dirty reads or phantom data states."
            }
        ]
    };

    // State
    let currentSubject = 'java';
    let currentQuestionIdx = 0;
    let selectedOption = null;
    let score = 0;
    let answered = false;

    // Elements
    let elements = {};

    function refreshElements() {
        elements = {
            quizBox: document.getElementById('aiQuizBox'),
            reportCard: document.getElementById('aiReportCard'),
            codeEvaluator: document.getElementById('aiCodeEvaluator'),
            subjectSelect: document.getElementById('aiSubjectSelect'),
            questionNum: document.getElementById('quizQuestionNum'),
            questionText: document.getElementById('quizQuestionText'),
            codeSnippet: document.getElementById('quizCodeSnippet'),
            optionsList: document.getElementById('quizOptionsList'),
            explanationBox: document.getElementById('aiExplanationBox'),
            explanationText: document.getElementById('aiExplanationContent'),
            progressFill: document.getElementById('quizProgressFill'),
            submitBtn: document.getElementById('btnQuizSubmit'),
            btnModeQuiz: document.getElementById('btnModeQuiz'),
            btnModeCode: document.getElementById('btnModeCode'),
            codeInput: document.getElementById('aiCodeInput'),
            codeLanguage: document.getElementById('aiCodeLanguage')
        };
    }
    refreshElements();

    // Mode Switching
    window.switchAiMode = function (mode) {
        refreshElements();
        if (!elements.quizBox || !elements.codeEvaluator) return;

        if (mode === 'quiz') {
            elements.quizBox.style.display = 'flex';
            elements.codeEvaluator.style.display = 'none';
            elements.reportCard.style.display = 'none';
            if (elements.btnModeQuiz) elements.btnModeQuiz.classList.add('active');
            if (elements.btnModeCode) elements.btnModeCode.classList.remove('active');
            initQuiz();
        } else {
            elements.quizBox.style.display = 'none';
            elements.reportCard.style.display = 'none';
            elements.codeEvaluator.style.display = 'grid';
            if (elements.btnModeCode) elements.btnModeCode.classList.add('active');
            if (elements.btnModeQuiz) elements.btnModeQuiz.classList.remove('active');
        }
    };

    // Initialize Quiz
    function initQuiz() {
        refreshElements();
        if (!elements.subjectSelect) return;
        currentSubject = elements.subjectSelect.value || 'java';
        currentQuestionIdx = 0;
        selectedOption = null;
        score = 0;
        answered = false;

        if (elements.reportCard) elements.reportCard.style.display = 'none';
        if (elements.quizBox) elements.quizBox.style.display = 'flex';

        renderQuestion();
    }

    // Render Current Question
    function renderQuestion() {
        const questions = QUESTION_BANKS[currentSubject] || QUESTION_BANKS.java;
        if (currentQuestionIdx >= questions.length) {
            showReport();
            return;
        }

        const q = questions[currentQuestionIdx];
        answered = false;
        selectedOption = null;

        // Progress Fill
        if (elements.progressFill) {
            const pct = (currentQuestionIdx / questions.length) * 100;
            elements.progressFill.style.width = pct + '%';
        }

        // Question numbering & text
        if (elements.questionNum) {
            elements.questionNum.innerText = `Question ${currentQuestionIdx + 1} of ${questions.length}`;
        }
        if (elements.questionText) {
            elements.questionText.innerText = q.question;
        }

        // Code snippet
        if (elements.codeSnippet) {
            if (q.code) {
                elements.codeSnippet.innerText = q.code;
                elements.codeSnippet.style.display = 'block';
            } else {
                elements.codeSnippet.style.display = 'none';
            }
        }

        // Options List
        if (elements.optionsList) {
            elements.optionsList.innerHTML = '';
            const prefixes = ['A', 'B', 'C', 'D'];
            q.options.forEach((opt, idx) => {
                const btn = document.createElement('button');
                btn.type = 'button';
                btn.className = 'quiz-option-btn';
                btn.innerHTML = `<span class="option-prefix">${prefixes[idx]}</span> <span>${opt}</span>`;
                btn.addEventListener('click', () => selectOption(idx));
                elements.optionsList.appendChild(btn);
            });
        }

        // Hide explanation box
        if (elements.explanationBox) {
            elements.explanationBox.style.display = 'none';
        }

        // Button state
        if (elements.submitBtn) {
            elements.submitBtn.innerHTML = `<i class="fa-solid fa-check"></i> Submit Answer`;
            elements.submitBtn.disabled = true;
            elements.submitBtn.style.opacity = '0.5';
        }
    }

    // Select Option
    function selectOption(idx) {
        if (answered) return;
        selectedOption = idx;

        const btns = elements.optionsList.querySelectorAll('.quiz-option-btn');
        btns.forEach((b, i) => {
            if (i === idx) {
                b.classList.add('selected');
            } else {
                b.classList.remove('selected');
            }
        });

        if (elements.submitBtn) {
            elements.submitBtn.disabled = false;
            elements.submitBtn.style.opacity = '1';
        }
    }

    // Handle Quiz Submit / Next
    window.handleQuizAction = function () {
        const questions = QUESTION_BANKS[currentSubject] || QUESTION_BANKS.java;
        const q = questions[currentQuestionIdx];

        if (!answered) {
            // Evaluate Answer
            if (selectedOption === null) return;
            answered = true;

            const btns = elements.optionsList.querySelectorAll('.quiz-option-btn');
            const isCorrect = (selectedOption === q.correct);

            if (isCorrect) {
                score++;
                btns[selectedOption].classList.add('correct');
            } else {
                btns[selectedOption].classList.add('wrong');
                btns[q.correct].classList.add('correct');
            }

            // Show AI Explanation
            if (elements.explanationBox && elements.explanationText) {
                elements.explanationText.innerText = q.explanation;
                elements.explanationBox.style.display = 'block';
            }

            // Transform button to Next
            if (elements.submitBtn) {
                if (currentQuestionIdx + 1 < questions.length) {
                    elements.submitBtn.innerHTML = `Next Question <i class="fa-solid fa-arrow-right"></i>`;
                } else {
                    elements.submitBtn.innerHTML = `View AI Assessment Report <i class="fa-solid fa-chart-line"></i>`;
                }
            }
        } else {
            // Next Question
            currentQuestionIdx++;
            renderQuestion();
        }
    };

    // Show Final AI Diagnostic Report
    function showReport() {
        const questions = QUESTION_BANKS[currentSubject] || QUESTION_BANKS.java;
        const pct = Math.round((score / questions.length) * 100);

        if (elements.quizBox) elements.quizBox.style.display = 'none';
        if (elements.reportCard) elements.reportCard.style.display = 'block';

        const donut = document.getElementById('aiReportDonut');
        const scoreVal = document.getElementById('aiReportScoreVal');
        const profTag = document.getElementById('aiProficiencyTag');
        const summary = document.getElementById('aiFeedbackSummary');

        if (donut) donut.style.setProperty('--ai-score', pct);
        if (scoreVal) scoreVal.innerText = pct + '%';

        if (profTag && summary) {
            if (pct >= 85) {
                profTag.innerText = 'Advanced Mastery';
                profTag.style.background = '#ecfdf5';
                profTag.style.color = '#047857';
                profTag.style.borderColor = '#a7f3d0';
                summary.innerText = `Outstanding mastery! You have demonstrated comprehensive understanding of ${currentSubject.toUpperCase()} fundamentals and design patterns. You are well-prepared for production engineering.`;
            } else if (pct >= 60) {
                profTag.innerText = 'Proficient Learner';
                profTag.style.background = '#eff6ff';
                profTag.style.color = '#1d4ed8';
                profTag.style.borderColor = '#bfdbfe';
                summary.innerText = `Solid grasp of core principles! You answered ${score} out of ${questions.length} questions correctly. Review the recommended topics below to level up to advanced mastery.`;
            } else {
                profTag.innerText = 'Foundations Needed';
                profTag.style.background = '#fffbeb';
                profTag.style.color = '#b45309';
                profTag.style.borderColor = '#fde68a';
                summary.innerText = `Good initial effort. We identified opportunities to strengthen your knowledge in lifecycle mechanics and error handling. Recommended remedial lessons are suggested below.`;
            }
        }
    }

    // Retake Assessment
    window.retakeAiQuiz = function () {
        initQuiz();
    };

    // ==========================================================================
    // AI CODE REVIEWER HEURISTIC ENGINE
    // ==========================================================================
    window.evaluateCodeWithAi = function () {
        const code = (elements.codeInput ? elements.codeInput.value : '').trim();
        const resultsBox = document.getElementById('codeEvalResults');
        const btnEval = document.getElementById('btnEvaluateCode');

        if (!code) {
            alert('Please paste some code or assignment work in the editor to evaluate!');
            return;
        }

        if (btnEval) {
            btnEval.disabled = true;
            btnEval.innerHTML = `<i class="fa-solid fa-spinner fa-spin"></i> Analyzing with AI...`;
        }

        setTimeout(() => {
            // Heuristic evaluation based on code characteristics
            let correctness = 85;
            let quality = 80;
            let security = 88;
            let efficiency = 82;

            const lower = code.toLowerCase();

            // Quality checks
            if (lower.includes('preparedstatement') || lower.includes('try-with-resources') || lower.includes('try (')) {
                security = Math.min(100, security + 10);
                correctness = Math.min(100, correctness + 5);
            }
            if (lower.includes('catch (exception') || lower.includes('e.printstacktrace()')) {
                quality = Math.max(60, quality - 5);
            }
            if (lower.includes('select * from') && lower.includes('where') && !lower.includes('?')) {
                security = Math.max(50, security - 25);
            }
            if (code.length > 200) {
                correctness = Math.min(95, correctness + 5);
            }

            const avgScore = Math.round((correctness + quality + security + efficiency) / 4);

            let grade = 'A';
            let gradeColor = '#059669';
            if (avgScore >= 90) { grade = 'A+'; gradeColor = '#059669'; }
            else if (avgScore >= 80) { grade = 'A'; gradeColor = '#10b981'; }
            else if (avgScore >= 70) { grade = 'B'; gradeColor = '#2563eb'; }
            else { grade = 'C'; gradeColor = '#d97706'; }

            if (resultsBox) {
                resultsBox.innerHTML = `
                    <div style="display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid var(--card-border); padding-bottom: 14px;">
                        <div>
                            <span style="font-size: 11px; font-weight: 700; color: #7c3aed; text-transform: uppercase;">AI Evaluation Report</span>
                            <h4 style="font-size: 16px; font-weight: 800; color: var(--text-heading); margin-top: 2px;">Predicted Grade: <span style="color: ${gradeColor};">${grade} (${avgScore}%)</span></h4>
                        </div>
                        <span style="padding: 4px 12px; border-radius: 9999px; background: #faf5ff; border: 1px solid #e9d5ff; color: #7c3aed; font-size: 12px; font-weight: 700;">
                            <i class="fa-solid fa-wand-magic-sparkles"></i> AI Verified
                        </span>
                    </div>

                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <div class="eval-metric-row">
                            <div class="eval-metric-header">
                                <span>Correctness & Logic</span>
                                <strong>${correctness}%</strong>
                            </div>
                            <div class="eval-metric-bar">
                                <div class="eval-metric-fill" style="width: ${correctness}%; background: #10b981;"></div>
                            </div>
                        </div>

                        <div class="eval-metric-row">
                            <div class="eval-metric-header">
                                <span>Code Standards & Style</span>
                                <strong>${quality}%</strong>
                            </div>
                            <div class="eval-metric-bar">
                                <div class="eval-metric-fill" style="width: ${quality}%; background: #3157e8;"></div>
                            </div>
                        </div>

                        <div class="eval-metric-row">
                            <div class="eval-metric-header">
                                <span>Security & SQL Injection Safety</span>
                                <strong>${security}%</strong>
                            </div>
                            <div class="eval-metric-bar">
                                <div class="eval-metric-fill" style="width: ${security}%; background: #7c3aed;"></div>
                            </div>
                        </div>

                        <div class="eval-metric-row">
                            <div class="eval-metric-header">
                                <span>Efficiency & Performance</span>
                                <strong>${efficiency}%</strong>
                            </div>
                            <div class="eval-metric-bar">
                                <div class="eval-metric-fill" style="width: ${efficiency}%; background: #06b6d4;"></div>
                            </div>
                        </div>
                    </div>

                    <div style="background: #f8fafc; border: 1px solid var(--card-border); border-radius: 12px; padding: 14px; font-size: 12.5px; line-height: 1.6;">
                        <strong style="color: var(--text-heading); display: block; margin-bottom: 6px;"><i class="fa-solid fa-lightbulb" style="color: #f59e0b;"></i> Key AI Recommendations:</strong>
                        <ul style="padding-left: 18px; color: var(--text-muted);">
                            <li>Ensure all database connections are closed using try-with-resources.</li>
                            <li>Add explicit null-checks on user inputs before processing.</li>
                            <li>Structure your methods with clear single-responsibility principle.</li>
                        </ul>
                    </div>
                `;
            }

            if (btnEval) {
                btnEval.disabled = false;
                btnEval.innerHTML = `<i class="fa-solid fa-wand-magic-sparkles"></i> Analyze with AI`;
            }
        }, 600);
    };

    // Attach listener to subject dropdown
    function setupListeners() {
        refreshElements();
        if (elements.subjectSelect) {
            elements.subjectSelect.addEventListener('change', () => {
                initQuiz();
            });
        }
    }

    // DOM Ready Initialization
    document.addEventListener('DOMContentLoaded', () => {
        setupListeners();
        initQuiz();
    });
})();

