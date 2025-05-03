$workflowPath = ".github\workflows"
New-Item -ItemType Directory -Force -Path $workflowPath | Out-Null

$ymlContent = @'
name: Sync Markdown Checklist to GitHub Issues

on:
  workflow_dispatch:

jobs:
  create-issues:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Parse checklist and create issues
        uses: alstr/todo-to-issue-action@v4
        with:
          TOKEN: ${{ secrets.GITHUB_TOKEN }}
          REPO: ${{ github.repository }}
          PATHS: "SI_ASSI_Task_Issues_Wrapped.md"
          LABEL: task
          COMMENT_MARKER: GITHUB-ISSUE
          CLOSE_ISSUES: false
          OPEN_ISSUES: true
'@

$ymlFile = "$workflowPath\create-issues-from-checklist.yml"
$ymlContent | Set-Content -Path $ymlFile -Encoding UTF8

Write-Host "✅ Workflow file created at: $ymlFile"


   