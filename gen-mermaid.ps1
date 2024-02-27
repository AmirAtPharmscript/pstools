 # Define the path to the input file as a parameter
param (
    [string]$InputFilePath
)

# Check if the input file exists
if (-not (Test-Path -Path $InputFilePath)) {
    Write-Error "File not found: $InputFilePath"
    exit
}

# Initialize the Mermaid chart code with the starting point
$mermaidCode = "graph LR;`n"

# Read the input file and process each line
$lines = Get-Content -Path $InputFilePath
for ($i = 0; $i -lt $lines.Count; $i++) {
    # Each line represents a node, create a node ID by using the line number
    $currentNode = $lines[$i].Trim()
    if ($i -lt $lines.Count - 1) {
        # If not the last line, create a link to the next node
        $nextNode = $lines[$i + 1].Trim()
        $mermaidCode += "    A$i" + "[" + $currentNode + "]" + " --> " + "A" + ($i + 1) + "[" + $nextNode + "];`n"
    }
}

# Output the Mermaid chart code
$mermaidCode

# Optionally, you can save this output to a file
# $OutputFilePath = "Path\To\Your\OutputFile.mmd"
# $mermaidCode | Out-File -FilePath $OutputFilePath 

