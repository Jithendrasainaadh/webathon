<?php
// dashboard.php - User dashboard after successful login
session_start();

// Check if user is logged in
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    header('Location: login.php');
    exit();
}

// Get user details from session
$user_name = $_SESSION['user_name'];
$user_email = $_SESSION['user_email'];
$user_role = $_SESSION['user_role'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - KrishiMitra AI</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div style="min-height: 100vh; background: #f5f5f5;">
        <!-- Header -->
        <div style="background: #27ae60; color: white; padding: 16px 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
            <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center;">
                <div style="display: flex; align-items: center; gap: 12px;">
                    <span style="font-size: 32px;">🌾</span>
                    <h1 style="font-size: 20px; font-weight: 600; margin: 0;">KrishiMitra AI</h1>
                </div>
                <div style="display: flex; align-items: center; gap: 20px;">
                    <span>Welcome, <?php echo htmlspecialchars($user_name); ?>!</span>
                    <a href="logout.php" style="background: rgba(255,255,255,0.2); padding: 8px 16px; border-radius: 6px; text-decoration: none; color: white; font-size: 14px;">Logout</a>
                </div>
            </div>
        </div>
        
        <!-- Main Content -->
        <div style="max-width: 1200px; margin: 0 auto; padding: 40px 20px;">
            <div class="welcome-section">
                <div class="welcome-title">Welcome back, <?php echo htmlspecialchars($user_name); ?>! 👋</div>
                <div class="welcome-text">How can I help with your farming today?</div>
            </div>
            
            <div style="margin-top: 30px;">
                <div class="section-title">Quick Actions</div>
                <div class="action-grid">
                    <div class="action-card">
                        <div class="action-icon">🌱</div>
                        <div class="action-label">Ask Question</div>
                    </div>
                    <div class="action-card">
                        <div class="action-icon">🔍</div>
                        <div class="action-label">View History</div>
                    </div>
                    <div class="action-card">
                        <div class="action-icon">☁️</div>
                        <div class="action-label">Weather Info</div>
                    </div>
                    <div class="action-card">
                        <div class="action-icon">📱</div>
                        <div class="action-label">Contact Expert</div>
                    </div>
                </div>
            </div>
            
            <div style="margin-top: 40px;">
                <div class="section-title">Your Recent Queries</div>
                <div class="history-item">
                    <div class="history-question">No queries yet. Start by asking a question!</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>