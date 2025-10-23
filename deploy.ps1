param(
  [ValidateSet("stg","prod")]
  [string]$env = "stg"
)

# GitHub Actions�i�{�ԁj�ȊO�� prod ������
$inCI = $env:GITHUB_ACTIONS -eq "true"
if ($env -eq "prod" -and -not $inCI) {
  Write-Error "? �{�ԃf�v���C�͋֎~�Fmain �}�[�W�Ŏ������f���Ă��������i���[�J������ prod �͕s�j"
  exit 1
}

# ���������� bare deploy ��h�~�i��� --only �������j
if ($env -eq "stg") {
  Write-Host "?? Deploy to staging..."
  firebase deploy --only hosting:staging
} else {
  Write-Host "?? Deploy to production (CI)..."
  firebase deploy --only hosting:production
}
