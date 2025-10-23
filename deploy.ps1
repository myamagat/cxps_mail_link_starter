param(
  [ValidateSet("stg","prod")]
  [string]$env = "stg"
)

# GitHub Actions（本番）以外で prod を拒否
$inCI = $env:GITHUB_ACTIONS -eq "true"
if ($env -eq "prod" -and -not $inCI) {
  Write-Error "? 本番デプロイは禁止：main マージで自動反映してください（ローカルから prod は不可）"
  exit 1
}

# 引数無しや bare deploy を防止（常に --only を強制）
if ($env -eq "stg") {
  Write-Host "?? Deploy to staging..."
  firebase deploy --only hosting:staging
} else {
  Write-Host "?? Deploy to production (CI)..."
  firebase deploy --only hosting:production
}
