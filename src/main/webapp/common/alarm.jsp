<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification Settings</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .setting-icon {
            margin-left: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2>알림 설정</h2>
    <div class="form-group">
        <label class="d-flex align-items-center">
            전체알림
            <input type="checkbox" class="form-switch ml-auto">
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            인증 게시글 알림
            <input type="checkbox" class="form-switch ml-auto">
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            모임 게시글 알림
            <input type="checkbox" class="form-switch ml-auto">
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            등산 안내 알림
            <input type="checkbox" class="form-switch ml-auto">
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            기타 알림
            <input type="checkbox" class="form-switch ml-auto">
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            설정
            <i class="fas fa-cog setting-icon"></i>
        </label>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
</html>