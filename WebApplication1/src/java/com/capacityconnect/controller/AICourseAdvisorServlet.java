package com.capacityconnect.controller;

import com.capacityconnect.dao.CourseDAO;
import com.capacityconnect.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 * Intelligent AI Course Recommendation Engine Servlet.
 * Analyzes student career goals, skill level, weekly study commitment,
 * technical interests, and learning style to generate personalized curriculum blueprints.
 */
@WebServlet("/AICourseAdvisorServlet")
public class AICourseAdvisorServlet extends HttpServlet {

    private CourseDAO courseDAO;

    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRecommendation(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRecommendation(request, response);
    }

    private void processRecommendation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String careerGoal = request.getParameter("careerGoal");
        String skillLevel = request.getParameter("skillLevel");
        String primaryInterest = request.getParameter("primaryInterest");
        String weeklyHours = request.getParameter("weeklyHours");
        String learningStyle = request.getParameter("learningStyle");

        if (careerGoal == null || careerGoal.trim().isEmpty()) {
            careerGoal = "Full Stack Web Developer";
        }
        if (skillLevel == null || skillLevel.trim().isEmpty()) {
            skillLevel = "Beginner";
        }
        if (primaryInterest == null || primaryInterest.trim().isEmpty()) {
            primaryInterest = "Java & Web";
        }
        if (weeklyHours == null || weeklyHours.trim().isEmpty()) {
            weeklyHours = "6-12";
        }
        if (learningStyle == null || learningStyle.trim().isEmpty()) {
            learningStyle = "Hands-on Projects";
        }

        // Fetch courses from DB (or fallback catalog)
        List<Course> allCourses = null;
        try {
            allCourses = courseDAO.getAllCourses();
        } catch (Exception ignored) {}

        if (allCourses == null || allCourses.isEmpty()) {
            allCourses = getDefaultCatalog();
        }

        // Run Recommendation Engine
        RecommendationResult result = evaluateRecommendation(allCourses, careerGoal, skillLevel, primaryInterest, weeklyHours, learningStyle);

        // Check if client expects JSON or JSP forward
        String format = request.getParameter("format");
        if ("html".equalsIgnoreCase(format)) {
            request.setAttribute("aiResult", result);
            request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);
            return;
        }

        // Return JSON response
        PrintWriter out = response.getWriter();
        out.print(result.toJson());
        out.flush();
    }

    /**
     * AI Multi-Dimensional Scoring Engine
     */
    private RecommendationResult evaluateRecommendation(
            List<Course> courses,
            String careerGoal,
            String skillLevel,
            String primaryInterest,
            String weeklyHours,
            String learningStyle) {

        String goalNorm = careerGoal.toLowerCase();
        String interestNorm = primaryInterest.toLowerCase();
        String levelNorm = skillLevel.toLowerCase();

        List<ScoredCourse> scored = new ArrayList<>();

        for (Course c : courses) {
            double score = 50.0; // Base score
            String title = (c.getTitle() != null ? c.getTitle() : "").toLowerCase();
            String cat = (c.getCategory() != null ? c.getCategory() : "").toLowerCase();
            String desc = (c.getDescription() != null ? c.getDescription() : "").toLowerCase();
            String lvl = (c.getLevel() != null ? c.getLevel() : "Beginner").toLowerCase();

            // 1. Goal alignment
            if (goalNorm.contains("full stack") || goalNorm.contains("web")) {
                if (title.contains("full stack") || title.contains("react") || title.contains("web") || title.contains("java")) score += 25;
            } else if (goalNorm.contains("ai") || goalNorm.contains("machine learning") || goalNorm.contains("data")) {
                if (title.contains("ai") || title.contains("machine learning") || title.contains("python") || cat.contains("ai")) score += 30;
            } else if (goalNorm.contains("cloud") || goalNorm.contains("devops")) {
                if (title.contains("cloud") || title.contains("devops") || title.contains("docker")) score += 30;
            } else if (goalNorm.contains("cyber") || goalNorm.contains("security")) {
                if (title.contains("cyber") || title.contains("security")) score += 30;
            } else if (goalNorm.contains("database") || goalNorm.contains("sql")) {
                if (title.contains("database") || title.contains("sql")) score += 30;
            }

            // 2. Technical Interest matching
            if (interestNorm.contains("java") && title.contains("java")) score += 20;
            if (interestNorm.contains("react") && title.contains("react")) score += 20;
            if (interestNorm.contains("python") && title.contains("python")) score += 20;
            if (interestNorm.contains("sql") && (title.contains("sql") || title.contains("database"))) score += 20;
            if (interestNorm.contains("cloud") && title.contains("cloud")) score += 20;
            if (interestNorm.contains("ai") && (title.contains("ai") || title.contains("machine"))) score += 20;

            // 3. Experience level calibration
            if (levelNorm.contains("beginner")) {
                if (lvl.contains("beginner") || title.contains("beginner") || title.contains("basics")) score += 15;
                else if (lvl.contains("advanced")) score -= 10;
            } else if (levelNorm.contains("intermediate")) {
                if (lvl.contains("intermediate")) score += 15;
            } else if (levelNorm.contains("advanced")) {
                if (lvl.contains("advanced") || lvl.contains("intermediate")) score += 15;
                else if (lvl.contains("beginner")) score -= 5;
            }

            // 4. Learning style adjustments
            if (learningStyle.toLowerCase().contains("project")) {
                if (desc.contains("build") || desc.contains("bootcamp") || desc.contains("practical")) score += 10;
            }

            int matchPct = (int) Math.min(99, Math.max(78, Math.round(score)));
            scored.add(new ScoredCourse(c, matchPct));
        }

        // Sort by match percentage descending
        scored.sort((a, b) -> Integer.compare(b.matchPercent, a.matchPercent));

        ScoredCourse top = scored.isEmpty() ? new ScoredCourse(courses.get(0), 96) : scored.get(0);
        List<ScoredCourse> pathway = new ArrayList<>();
        for (int i = 1; i < Math.min(3, scored.size()); i++) {
            pathway.add(scored.get(i));
        }

        // Generate AI Reasoning & 3-Step Milestone Roadmap
        String reasoning = generateAiReasoning(top.course, careerGoal, skillLevel, primaryInterest, weeklyHours);
        List<String> roadmap = generateRoadmap(top.course, careerGoal);

        return new RecommendationResult(top, pathway, reasoning, roadmap, careerGoal, skillLevel, weeklyHours);
    }

    private String generateAiReasoning(Course course, String careerGoal, String skillLevel, String primaryInterest, String weeklyHours) {
        return String.format(
            "Capacity AI calibrated this recommendation for your target role as '%s'. Given your '%s' proficiency in %s, " +
            "this curriculum focuses directly on bridging architectural fundamentals with scalable production systems. " +
            "With your commitment of %s hours/week, you will complete hands-on milestones on schedule with maximum retention.",
            careerGoal, skillLevel, primaryInterest, weeklyHours
        );
    }

    private List<String> generateRoadmap(Course course, String careerGoal) {
        List<String> roadmap = new ArrayList<>();
        String title = course.getTitle() != null ? course.getTitle() : "Course Foundations";

        roadmap.add("Phase 1: Core Fundamentals & Syntax Mastery (" + title + " foundational modules)");
        roadmap.add("Phase 2: Real-World Architecture & Guided Projects (Practical implementations aligned with " + careerGoal + ")");
        roadmap.add("Phase 3: Production Capstone, Testing & Placement Preparation");
        return roadmap;
    }

    private List<Course> getDefaultCatalog() {
        List<Course> list = new ArrayList<>();

        Course c1 = new Course();
        c1.setId(1);
        c1.setTitle("Java Programming for Beginners");
        c1.setCategory("Programming");
        c1.setLevel("Beginner");
        c1.setDuration("12 Weeks");
        c1.setDescription("Master Java from syntax to OOP, collections, multithreading, and real-world system architecture.");
        c1.setThumbnail("images/course-java.jpg");
        list.add(c1);

        Course c2 = new Course();
        c2.setId(2);
        c2.setTitle("React JS & Modern Web Development");
        c2.setCategory("Web Development");
        c2.setLevel("Intermediate");
        c2.setDuration("8 Weeks");
        c2.setDescription("Build high-performance client applications using React 18, Hooks, state management, and Tailwind CSS.");
        c2.setThumbnail("images/course-web.jpg");
        list.add(c2);

        Course c3 = new Course();
        c3.setId(3);
        c3.setTitle("Python Basics & Algorithmic Thinking");
        c3.setCategory("Programming");
        c3.setLevel("Beginner");
        c3.setDuration("6 Weeks");
        c3.setDescription("Hands-on Python course covering data structures, algorithmic puzzles, APIs, and practical scripting.");
        c3.setThumbnail("images/course-python.jpg");
        list.add(c3);

        Course c4 = new Course();
        c4.setId(4);
        c4.setTitle("Artificial Intelligence & Machine Learning");
        c4.setCategory("AI & ML");
        c4.setLevel("Advanced");
        c4.setDuration("14 Weeks");
        c4.setDescription("Comprehensive machine learning curriculum from regression and classification to neural networks and LLMs.");
        c4.setThumbnail("images/course-ai.jpg");
        list.add(c4);

        Course c5 = new Course();
        c5.setId(5);
        c5.setTitle("Cloud Computing & DevOps Engineering");
        c5.setCategory("Cloud");
        c5.setLevel("Intermediate");
        c5.setDuration("10 Weeks");
        c5.setDescription("Containerization with Docker, Kubernetes clustering, CI/CD pipelines, and AWS cloud deployment.");
        c5.setThumbnail("images/course-cloud.jpg");
        list.add(c5);

        Course c6 = new Course();
        c6.setId(6);
        c6.setTitle("Full Stack Web Development Bootcamp");
        c6.setCategory("Full Stack");
        c6.setLevel("Intermediate");
        c6.setDuration("16 Weeks");
        c6.setDescription("End-to-end full stack mastery covering Frontend, Backend REST APIs, SQL databases, and cloud hosting.");
        c6.setThumbnail("images/full-stack.jpg");
        list.add(c6);

        Course c7 = new Course();
        c7.setId(7);
        c7.setTitle("Database Systems & SQL Optimization");
        c7.setCategory("Database");
        c7.setLevel("Beginner");
        c7.setDuration("6 Weeks");
        c7.setDescription("Relational database design, ACID compliance, query optimization, indexing, and enterprise schema tuning.");
        c7.setThumbnail("images/course-database.jpg");
        list.add(c7);

        return list;
    }

    // Helper classes
    public static class ScoredCourse {
        public Course course;
        public int matchPercent;

        public ScoredCourse(Course course, int matchPercent) {
            this.course = course;
            this.matchPercent = matchPercent;
        }
    }

    public static class RecommendationResult {
        public ScoredCourse topCourse;
        public List<ScoredCourse> pathwayCourses;
        public String aiReasoning;
        public List<String> roadmap;
        public String targetCareer;
        public String skillLevel;
        public String weeklyHours;

        public RecommendationResult(ScoredCourse topCourse, List<ScoredCourse> pathwayCourses, String aiReasoning, List<String> roadmap, String targetCareer, String skillLevel, String weeklyHours) {
            this.topCourse = topCourse;
            this.pathwayCourses = pathwayCourses;
            this.aiReasoning = aiReasoning;
            this.roadmap = roadmap;
            this.targetCareer = targetCareer;
            this.skillLevel = skillLevel;
            this.weeklyHours = weeklyHours;
        }

        public String toJson() {
            StringBuilder sb = new StringBuilder();
            sb.append("{");
            sb.append("\"status\":\"success\",");
            sb.append("\"targetCareer\":\"").append(escape(targetCareer)).append("\",");
            sb.append("\"skillLevel\":\"").append(escape(skillLevel)).append("\",");
            sb.append("\"weeklyHours\":\"").append(escape(weeklyHours)).append("\",");
            sb.append("\"aiReasoning\":\"").append(escape(aiReasoning)).append("\",");

            // Top Course
            sb.append("\"topCourse\":{");
            sb.append("\"id\":").append(topCourse.course.getId()).append(",");
            sb.append("\"title\":\"").append(escape(topCourse.course.getTitle())).append("\",");
            sb.append("\"category\":\"").append(escape(topCourse.course.getCategory())).append("\",");
            sb.append("\"level\":\"").append(escape(topCourse.course.getLevel())).append("\",");
            sb.append("\"duration\":\"").append(escape(topCourse.course.getDuration())).append("\",");
            sb.append("\"description\":\"").append(escape(topCourse.course.getDescription())).append("\",");
            sb.append("\"thumbnail\":\"").append(escape(topCourse.course.getThumbnail())).append("\",");
            sb.append("\"matchPercent\":").append(topCourse.matchPercent);
            sb.append("},");

            // Roadmap
            sb.append("\"roadmap\":[");
            for (int i = 0; i < roadmap.size(); i++) {
                sb.append("\"").append(escape(roadmap.get(i))).append("\"");
                if (i < roadmap.size() - 1) sb.append(",");
            }
            sb.append("],");

            // Pathway courses
            sb.append("\"pathwayCourses\":[");
            for (int i = 0; i < pathwayCourses.size(); i++) {
                ScoredCourse sc = pathwayCourses.get(i);
                sb.append("{");
                sb.append("\"id\":").append(sc.course.getId()).append(",");
                sb.append("\"title\":\"").append(escape(sc.course.getTitle())).append("\",");
                sb.append("\"category\":\"").append(escape(sc.course.getCategory())).append("\",");
                sb.append("\"level\":\"").append(escape(sc.course.getLevel())).append("\",");
                sb.append("\"matchPercent\":").append(sc.matchPercent);
                sb.append("}");
                if (i < pathwayCourses.size() - 1) sb.append(",");
            }
            sb.append("]");

            sb.append("}");
            return sb.toString();
        }

        private String escape(String s) {
            if (s == null) return "";
            return s.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "");
        }
    }
}
