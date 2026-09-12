<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.capacityconnect.model.Student" %>
<%@ page import="com.capacityconnect.dao.StudentDAO" %>

<%
    // Authentication check
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null 
            || !"STUDENT".equalsIgnoreCase((String) userSession.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int studentId = (Integer) userSession.getAttribute("userId");
    StudentDAO studentDAO = new StudentDAO();

    Student student = (Student) request.getAttribute("student");
    if (student == null) {
        student = studentDAO.getStudentById(studentId);
        if (student == null) {
            student = new Student();
            student.setId(studentId);
            student.setName((String) userSession.getAttribute("userName"));
            student.setEmail((String) userSession.getAttribute("email"));
        }
    }

    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    if (stats == null) {
        stats = studentDAO.getDashboardStats(studentId);
    }

    List<Map<String, Object>> certificates = (List<Map<String, Object>>) request.getAttribute("certificates");
    if (certificates == null) {
        certificates = studentDAO.getStudentCertificates(studentId);
    }

    int certCount = certificates != null ? certificates.size() : 0;
    String studentName = (student.getName() != null && !student.getName().trim().isEmpty()) 
            ? student.getName().trim() : "Student";

    request.setAttribute("activePage", "certificates");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verified Certificates | Capacity Connect</title>

    <!-- Google Fonts Inter & Playfair for Diploma -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&amp;family=Playfair+Display:ital,wght@0,600;0,800;1,600&amp;display=swap" rel="stylesheet">

    <!-- Font Awesome 6.5.2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- User Standard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

    <style>
        .cert-card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 24px;
        }
        .cert-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 28px;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: .3s;
            box-shadow: 0 4px 15px rgba(30, 40, 70, 0.02);
        }
        .cert-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 36px rgba(30, 40, 70, 0.08);
        }
        .cert-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #3157e8, #7c3aed, #f59e0b);
        }
        .cert-seal-icon {
            width: 54px;
            height: 54px;
            border-radius: 16px;
            background: linear-gradient(135deg, #fffbeb, #fef3c7);
            border: 1px solid #fde68a;
            color: #d97706;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 18px;
        }
        .cert-number-box {
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 8px 12px;
            font-family: monospace;
            font-size: 12px;
            color: #475569;
            margin: 14px 0 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Modal Styles */
        .cert-modal-backdrop {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.7);
            backdrop-filter: blur(4px);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .cert-modal-backdrop.active {
            display: flex;
        }
        .cert-modal-dialog {
            background: #ffffff;
            border-radius: 20px;
            max-width: 760px;
            width: 100%;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
            animation: modalPop .25s ease;
        }
        @keyframes modalPop {
            from { transform: scale(0.92); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
        .cert-diploma-sheet {
            padding: 45px 50px;
            background: #ffffff;
            border: 12px solid #1e293b;
            outline: 2px solid #d97706;
            outline-offset: -8px;
            text-align: center;
            position: relative;
        }
        .diploma-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 30px;
            color: #1e293b;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .diploma-recipient {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 800;
            color: #3157e8;
            margin: 18px 0;
            text-decoration: underline;
            text-decoration-color: #fde68a;
        }
        .diploma-course-name {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
            margin: 12px 0 16px;
        }
        .diploma-signatures {
            display: flex;
            justify-content: space-between;
            margin-top: 36px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }
        .signature-line {
            text-align: center;
        }
        .signature-line strong {
            display: block;
            font-size: 13px;
            color: #1e293b;
        }
        .signature-line span {
            font-size: 11px;
            color: #64748b;
        }
        @media print {
            body * { visibility: hidden; }
            #printableDiploma, #printableDiploma * { visibility: visible; }
            #printableDiploma { position: absolute; left: 0; top: 0; width: 100%; }
        }
    </style>
</head>
<body>

<div class="user-layout">

    <!-- Reusable Sidebar -->
    <jsp:include page="/includes/user-sidebar.jsp" />

    <!-- Main Content -->
    <main class="user-main">

        <!-- Topbar -->
        <header class="user-topbar">
            <div>
                <span class="topbar-label">CREDENTIALS VAULT</span>
                <h1>Verified Course Certificates</h1>
            </div>
            <div class="user-profile-mini">
                <div class="mini-avatar"><%= studentName.substring(0, 1).toUpperCase() %></div>
                <div>
                    <strong style="display: block; font-size: 13px; color: var(--dark);"><%= studentName %></strong>
                    <span style="font-size: 11px; color: var(--muted);">Student ID: #<%= student.getId() %></span>
                </div>
            </div>
        </header>

        <!-- Intro Banner -->
        <div class="page-intro">
            <span>OFFICIAL CERTIFICATION</span>
            <h2>Showcase Your Academic Achievements</h2>
            <p>Every certificate is cryptographically assigned a unique ID upon completing 100% curriculum requirements and passing instructor evaluations. Share or download your achievements anytime.</p>
        </div>

        <!-- KPI Stats Grid -->
        <div class="user-stats-grid">
            <div class="user-stat-card">
                <div class="user-stat-icon blue">
                    <i class="fa-solid fa-award"></i>
                </div>
                <span>AWARDED CREDENTIALS</span>
                <strong><%= certCount %></strong>
                <small>Official graduation diplomas</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon green">
                    <i class="fa-solid fa-shield-check"></i>
                </div>
                <span>VERIFICATION STATUS</span>
                <strong>100%</strong>
                <small>Digitally verified records</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon purple">
                    <i class="fa-solid fa-graduation-cap"></i>
                </div>
                <span>ACADEMIC HONORS</span>
                <strong>Level <%= certCount > 0 ? "Gold" : "Standard" %></strong>
                <small>Curriculum distinction</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon orange">
                    <i class="fa-solid fa-share-nodes"></i>
                </div>
                <span>PUBLIC SHAREABLE</span>
                <strong>Active</strong>
                <small>Ready for CV &amp; portfolio</small>
            </div>
        </div>

        <!-- Certificate Cards Grid -->
        <% if (certificates == null || certificates.isEmpty()) { %>
            <div class="empty-state">
                <i class="fa-solid fa-award"></i>
                <h3>No Certificates Earned Yet</h3>
                <p>Complete 100% of your course syllabus and assignments to automatically unlock your accredited certificate of completion.</p>
                <a href="${pageContext.request.contextPath}/user/my-courses.jsp" class="btn-user-primary" style="margin-top: 18px;">
                    <i class="fa-solid fa-book-bookmark"></i> Continue Course Learning
                </a>
            </div>
        <% } else { %>
            <div class="cert-card-grid">
                <% for (Map<String, Object> cert : certificates) { 
                    String certNum = cert.get("certificateNumber") != null ? String.valueOf(cert.get("certificateNumber")) : "CC-VERIFIED";
                    String issueDate = cert.get("issueDate") != null ? String.valueOf(cert.get("issueDate")) : "N/A";
                    String courseTitle = cert.get("courseTitle") != null ? String.valueOf(cert.get("courseTitle")) : "Coursework";
                    String category = cert.get("category") != null ? String.valueOf(cert.get("category")) : "Academic";
                %>
                <div class="cert-card">
                    <div>
                        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                            <div class="cert-seal-icon">
                                <i class="fa-solid fa-award"></i>
                            </div>
                            <span class="status-pill completed">
                                <i class="fa-solid fa-check"></i> VERIFIED
                            </span>
                        </div>

                        <span style="font-size: 11px; font-weight: 800; color: var(--primary); letter-spacing: 1.2px; text-transform: uppercase;">
                            <%= category %>
                        </span>

                        <h3 style="font-size: 18px; font-weight: 800; color: var(--dark); margin: 6px 0 10px;">
                            <%= courseTitle %>
                        </h3>

                        <p style="color: var(--muted); font-size: 13px; line-height: 1.5;">
                            Successfully fulfilled all course requirements, practical projects, and academic assessments.
                        </p>

                        <div class="cert-number-box">
                            <span><i class="fa-solid fa-barcode" style="margin-right: 6px;"></i> <%= certNum %></span>
                            <span style="color: var(--muted); font-size: 11px;"><%= issueDate %></span>
                        </div>
                    </div>

                    <div style="display: flex; gap: 10px;">
                        <button type="button" class="btn-user-primary btn-view-diploma" style="flex: 1; font-size: 12.5px; padding: 10px;"
                                data-student="<%= studentName %>"
                                data-course="<%= courseTitle %>"
                                data-cert="<%= certNum %>"
                                data-date="<%= issueDate %>">
                            <i class="fa-solid fa-eye"></i> View Diploma
                        </button>
                        <button type="button" class="btn-user-secondary btn-copy-cert" style="font-size: 12.5px; padding: 10px 14px;"
                                data-cert="<%= certNum %>"
                                title="Copy Certificate Number">
                            <i class="fa-regular fa-copy"></i>
                        </button>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>

    </main>
</div>

<!-- Interactive Printable Diploma Modal -->
<div class="cert-modal-backdrop" id="certModal">
    <div class="cert-modal-dialog">
        <div id="printableDiploma" class="cert-diploma-sheet">
            <div style="font-size: 42px; color: #d97706; margin-bottom: 10px;">
                <i class="fa-solid fa-award"></i>
            </div>
            <div class="diploma-header">
                <span>CAPACITY CONNECT UNIVERSITY PORTAL</span>
                <h2>Certificate of Completion</h2>
                <p style="font-size: 13px; color: #64748b; letter-spacing: 1px; text-transform: uppercase;">This document officially certifies that</p>
            </div>

            <div class="diploma-recipient" id="modalStudentName"><%= studentName %></div>

            <p style="font-size: 14px; color: #475569; max-width: 520px; margin: 0 auto;">
                has successfully completed the comprehensive curriculum, assignments, and examination for
            </p>

            <div class="diploma-course-name" id="modalCourseTitle">Course Title</div>

            <div style="display: inline-block; background: #f8fafc; border: 1px dashed #cbd5e1; padding: 6px 16px; border-radius: 8px; font-family: monospace; font-size: 12px; color: #334155;">
                Credential Verification ID: <strong id="modalCertNumber">CC-0000</strong>
            </div>

            <div class="diploma-signatures">
                <div class="signature-line">
                    <strong id="modalIssueDate">Date</strong>
                    <span>Date of Issue</span>
                </div>
                <div class="signature-line">
                    <strong>Capacity Connect</strong>
                    <span>Academic Directorate</span>
                </div>
                <div class="signature-line">
                    <strong style="color: #16a34a;"><i class="fa-solid fa-badge-check"></i> VERIFIED</strong>
                    <span>Digital Seal</span>
                </div>
            </div>
        </div>

        <div style="background: #f8fafc; padding: 16px 24px; display: flex; justify-content: flex-end; gap: 12px; border-top: 1px solid var(--border);">
            <button type="button" class="btn-user-secondary" onclick="closeDiplomaModal()">
                Close
            </button>
            <button type="button" class="btn-user-primary" onclick="window.print()">
                <i class="fa-solid fa-print"></i> Print / Download PDF
            </button>
        </div>
    </div>
</div>

<script>
    function openDiplomaModal(studentName, courseTitle, certNumber, issueDate) {
        document.getElementById('modalStudentName').innerText = studentName;
        document.getElementById('modalCourseTitle').innerText = courseTitle;
        document.getElementById('modalCertNumber').innerText = certNumber;
        document.getElementById('modalIssueDate').innerText = issueDate;
        document.getElementById('certModal').classList.add('active');
    }

    function closeDiplomaModal() {
        document.getElementById('certModal').classList.remove('active');
    }

    document.getElementById('certModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeDiplomaModal();
        }
    });

    // Unobtrusive event delegation for clean, error-free modal triggering
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.btn-view-diploma').forEach(function(btn) {
            btn.addEventListener('click', function() {
                var sName = this.getAttribute('data-student') || '';
                var cTitle = this.getAttribute('data-course') || '';
                var cNum = this.getAttribute('data-cert') || '';
                var iDate = this.getAttribute('data-date') || '';
                openDiplomaModal(sName, cTitle, cNum, iDate);
            });
        });

        document.querySelectorAll('.btn-copy-cert').forEach(function(btn) {
            btn.addEventListener('click', function() {
                var certNum = this.getAttribute('data-cert') || '';
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(certNum).catch(function() {});
                }
                alert('Certificate Number copied to clipboard: ' + certNum);
            });
        });
    });
</script>

</body>
</html>
