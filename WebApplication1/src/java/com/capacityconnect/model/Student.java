package com.capacityconnect.model;

/**
 * Model representing a Student in Capacity Connect.
 * In the database schema, students are users with role = 'STUDENT'.
 */
public class Student extends User {

    private int enrolledCourseCount;
    private int completedCourseCount;
    private double averageProgress;
    private int totalAssignments;
    private int pendingAssignments;
    private int submittedAssignments;
    private double attendanceRate;
    private int certificateCount;

    public Student() {
        super();
        setRole("STUDENT");
    }

    public Student(int id, String name, String email, String password) {
        super(id, name, email, password, "STUDENT");
    }

    public int getEnrolledCourseCount() {
        return enrolledCourseCount;
    }

    public void setEnrolledCourseCount(int enrolledCourseCount) {
        this.enrolledCourseCount = enrolledCourseCount;
    }

    public int getCompletedCourseCount() {
        return completedCourseCount;
    }

    public void setCompletedCourseCount(int completedCourseCount) {
        this.completedCourseCount = completedCourseCount;
    }

    public double getAverageProgress() {
        return averageProgress;
    }

    public void setAverageProgress(double averageProgress) {
        this.averageProgress = averageProgress;
    }

    public int getTotalAssignments() {
        return totalAssignments;
    }

    public void setTotalAssignments(int totalAssignments) {
        this.totalAssignments = totalAssignments;
    }

    public int getPendingAssignments() {
        return pendingAssignments;
    }

    public void setPendingAssignments(int pendingAssignments) {
        this.pendingAssignments = pendingAssignments;
    }

    public int getSubmittedAssignments() {
        return submittedAssignments;
    }

    public void setSubmittedAssignments(int submittedAssignments) {
        this.submittedAssignments = submittedAssignments;
    }

    public double getAttendanceRate() {
        return attendanceRate;
    }

    public void setAttendanceRate(double attendanceRate) {
        this.attendanceRate = attendanceRate;
    }

    public int getCertificateCount() {
        return certificateCount;
    }

    public void setCertificateCount(int certificateCount) {
        this.certificateCount = certificateCount;
    }
}
